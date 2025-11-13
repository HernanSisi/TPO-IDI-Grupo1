-------------------------- TRIGGER GENERAR GASTO AL RESERVAR ----------------------------------------
CREATE TRIGGER generarGastoAlReservar
ON Reserva
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Asegurar existencia de valores por defecto (creamos minimos si falta)
    IF NOT EXISTS (SELECT 1 FROM Origen WHERE Nombre_Origen = 'Sistema')
        INSERT INTO Origen (Nombre_Origen) VALUES ('Sistema');

    IF NOT EXISTS (SELECT 1 FROM Rol WHERE Nombre_Rol = 'Sistema')
        INSERT INTO Rol (Nombre_Rol, Descripcion_Rol) VALUES ('Sistema', 'Usuario sistema');

    IF NOT EXISTS (
        SELECT 1 FROM Personal p JOIN Rol r ON p.ID_Rol = r.ID_Rol WHERE r.Nombre_Rol = 'Sistema'
    )
    BEGIN
        DECLARE @idRol INT = (SELECT TOP 1 ID_Rol FROM Rol WHERE Nombre_Rol = 'Sistema');
        INSERT INTO Personal (Cedula_Personal, Email_Personal, Nombre1_Personal, Apellido1_Personal, Fecha_Nacimiento_Personal, Fecha_Contratacion, ID_Rol)
        VALUES ('00000000','sistema@example.com','Sistema','Sistema','1970-01-01',GETDATE(),@idRol);
    END

    -- Obtener defaults (siempre con TOP 1 para evitar fallos en multi-row)
    DECLARE @Producto_Default INT;
    SELECT TOP 1 @Producto_Default = ID_Producto FROM Producto WHERE Nombre_Producto LIKE '%Habitacion%';
    IF @Producto_Default IS NULL
        SELECT TOP 1 @Producto_Default = ID_Producto FROM Producto;

    DECLARE @Personal_Default INT;
    SELECT TOP 1 @Personal_Default = p.ID_Personal
    FROM Personal p
    JOIN Rol r ON p.ID_Rol = r.ID_Rol
    WHERE r.Nombre_Rol = 'Sistema';
    IF @Personal_Default IS NULL
        SELECT TOP 1 @Personal_Default = ID_Personal FROM Personal;

    DECLARE @Origen_Default INT;
    SELECT TOP 1 @Origen_Default = ID_Origen FROM Origen WHERE Nombre_Origen = 'Sistema';
    IF @Origen_Default IS NULL
        SELECT TOP 1 @Origen_Default = ID_Origen FROM Origen;

    -- Si no encontramos defaults criticos, abortamos con mensaje claro
    IF @Personal_Default IS NULL OR @Origen_Default IS NULL
    BEGIN
        -- Mensaje sencillo y rollback explicito (mas facil de explicar en la presentacion)
        RAISERROR('Faltan datos por defecto (Personal/Origen).', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Insertar gastos para las filas de 'inserted' de forma set-based
    --hacemos un select dentro de el siguiente insert 
    INSERT INTO Gasto (Importe, Producto_Gasto, Cantidad_Producto, ID_Personal, ID_Reserva, Origen_Gasto)
    SELECT
        -- Calculamos importe = precio_habitacion * noches, sin usar DATEDIFF(day,...)
        COALESCE(th.Precio_Habitacion, 0) *
            CASE
                -- Si faltan fechas de reserva, cobrar 1 unidad por defecto
                WHEN i.Fecha_Reserva_Inicio IS NULL OR i.Fecha_Reserva_Fin IS NULL THEN 1
                -- Calculamos dias como diferencia entre las fechas convertidas a DATE y casteadas a FLOAT
                WHEN CAST(CONVERT(date, i.Fecha_Reserva_Fin) AS float) - CAST(CONVERT(date, i.Fecha_Reserva_Inicio) AS float) > 0
                    -- entonces redondeamos convirtiendo la resta a INT
                    THEN CONVERT(INT, CAST(CONVERT(date, i.Fecha_Reserva_Fin) AS float) - CAST(CONVERT(date, i.Fecha_Reserva_Inicio) AS float))
                ELSE 1
            END AS Importe,
            -- luego de hallar la cant noches, se multiplica todo eso por el precio de la habitacion
            -- o sea coalesce precio_habitacion * cant_noches (hallado)
        @Producto_Default AS Producto_Gasto,
        1 AS Cantidad_Producto,
        @Personal_Default AS ID_Personal,
        i.ID_Reserva,
        @Origen_Default AS Origen_Gasto
    FROM inserted i
    LEFT JOIN Habitacion h ON h.ID_Nro_Habitacion = i.ID_Habitacion
    LEFT JOIN TipoHabitacion th ON th.ID_Tipo_Habitacion = h.Tipo_Habitacion;
END;
GO


------------ TRIGGER CONTROL DE STOCK --------

CREATE TRIGGER ControlStock
ON Gasto
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Proposito: Controlar que no se pueda insertar un gasto que reduzca el stock de un producto por debajo de cero.

    -- (1) Verificar si algun producto no tiene stock suficiente
    IF EXISTS (
        SELECT 1
        FROM (
            SELECT Producto_Gasto AS ID_Producto, SUM(Cantidad_Producto) AS ConsumoTotal
            FROM inserted
            WHERE Producto_Gasto IS NOT NULL
            GROUP BY Producto_Gasto
        ) AS c
        JOIN Producto p ON p.ID_Producto = c.ID_Producto
        WHERE p.Stock_Producto < c.ConsumoTotal
    )
    BEGIN
        DECLARE @EjID INT, @StockActual INT, @Requerido INT;
        SELECT TOP (1)
            @EjID = c.ID_Producto,
            @Requerido = c.ConsumoTotal,
            @StockActual = p.Stock_Producto
        FROM (
            SELECT Producto_Gasto AS ID_Producto, SUM(Cantidad_Producto) AS ConsumoTotal
            FROM inserted
            WHERE Producto_Gasto IS NOT NULL
            GROUP BY Producto_Gasto
        ) AS c
        JOIN Producto p ON p.ID_Producto = c.ID_Producto
        WHERE p.Stock_Producto < c.ConsumoTotal;

        RAISERROR('¡Stock insuficiente para producto ID=%d (stock=%d, requerido=%d)! Operacion cancelada.',
                16, 1, @EjID, @StockActual, @Requerido);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- (2) Si todo OK, aplicar la resta de stock
    UPDATE p
    SET p.Stock_Producto = p.Stock_Producto - c.ConsumoTotal
    FROM Producto p
    JOIN (
        SELECT Producto_Gasto AS ID_Producto, SUM(Cantidad_Producto) AS ConsumoTotal
        FROM inserted
        WHERE Producto_Gasto IS NOT NULL
        GROUP BY Producto_Gasto
    ) AS c ON p.ID_Producto = c.ID_Producto;
END;
GO