CREATE TRIGGER generarGastoAlReservarChad
ON Reserva
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Fallbacks para claves foráneas: buscar valores 'Sistema' o tomar cualquier registro existente
    DECLARE @Producto_Gasto_Default INT = (SELECT TOP 1 ID_Producto FROM Producto WHERE Nombre_Producto LIKE '%Habitacion%');
    IF @Producto_Gasto_Default IS NULL
        SELECT TOP 1 @Producto_Gasto_Default = ID_Producto FROM Producto;

    DECLARE @ID_Personal_Default INT = (
        SELECT TOP 1 P.ID_Personal
        FROM Personal P
        JOIN Rol R ON P.ID_Rol = R.ID_Rol
        WHERE R.Nombre_Rol = 'Sistema'
    );
    IF @ID_Personal_Default IS NULL
        SELECT TOP 1 @ID_Personal_Default = ID_Personal FROM Personal;

    DECLARE @Origen_Gasto_Default INT = (SELECT TOP 1 ID_Origen FROM Origen WHERE Nombre_Origen = 'Sistema');
    IF @Origen_Gasto_Default IS NULL
        SELECT TOP 1 @Origen_Gasto_Default = ID_Origen FROM Origen;

    -- Insertar en Gasto usando INSERT ... SELECT para manejar múltiples filas en 'inserted'
    INSERT INTO Gasto (Importe, Producto_Gasto, Cantidad_Producto, ID_Personal, ID_Reserva, Origen_Gasto)
    SELECT
        -- Importe = precio por noche * noches (mínimo 1)
        ISNULL(th.Precio_Habitacion, 0) *
            CASE WHEN DATEDIFF(day, i.Fecha_CheckIn, i.Fecha_CheckOut) > 0
                 THEN DATEDIFF(day, i.Fecha_CheckIn, i.Fecha_CheckOut)
                 ELSE 1 END AS Importe,
        ISNULL(@Producto_Gasto_Default, 1) AS Producto_Gasto,
        1 AS Cantidad_Producto,
        ISNULL(@ID_Personal_Default, 1) AS ID_Personal,
        i.ID_Reserva,
        ISNULL(@Origen_Gasto_Default, 1) AS Origen_Gasto
    FROM inserted i
    LEFT JOIN Habitacion h ON h.ID_Nro_Habitacion = i.ID_Habitacion
    LEFT JOIN TipoHabitacion th ON th.ID_Tipo_Habitacion = h.Tipo_Habitacion;

END;