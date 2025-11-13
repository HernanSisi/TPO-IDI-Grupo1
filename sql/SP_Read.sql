CREATE PROCEDURE SP_Read_PedidoDetalle
    @ID_Pedido INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validacion de existencia
    IF NOT EXISTS (SELECT 1 FROM Pedido WHERE ID_Pedido = @ID_Pedido)
    BEGIN
        RAISERROR('No existe pedido con ese ID.', 16, 1);
        RETURN;
    END

    -- Un solo SELECT: encabezado + detalle (una fila por producto)
    SELECT
        p.ID_Pedido,
        p.Fecha_Pedido,
        pr.CUIL_CUIT_Proveedor,
        pr.Razon_Social_Proveedor,
        pr.Telefono_Proveedor,
        pr.Email_Proveedor,
        pp.ID_Producto,
        prod.Nombre_Producto,
        pp.Cantidad_Producto,
        pp.Costo_unidad,
        Subtotal     = pp.Cantidad_Producto * pp.Costo_unidad,
        Total_Pedido = SUM(pp.Cantidad_Producto * pp.Costo_unidad) 
                       OVER (PARTITION BY p.ID_Pedido)
    FROM Pedido p
    INNER JOIN Proveedor pr      ON pr.CUIL_CUIT_Proveedor = p.CUIL_CUIT_Proveedor
    LEFT  JOIN Pedido_Producto pp ON pp.ID_Pedido = p.ID_Pedido
    LEFT  JOIN Producto prod      ON prod.ID_Producto = pp.ID_Producto
    WHERE p.ID_Pedido = @ID_Pedido
    ORDER BY prod.Nombre_Producto;
END
GO

CREATE PROCEDURE SP_Read_GastoReserva
    @ID_Reserva INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE ID_Reserva = @ID_Reserva)
    BEGIN
        RAISERROR('No existe reserva con ese ID.', 16, 1);
        RETURN;
    END

    SELECT
        r.ID_Reserva,
        r.Fecha_Reserva,
        Total_Gastos         = COUNT(g.ID_Gasto),
        Total_Activos        = SUM(CASE WHEN g.Estado_Gasto = 1 THEN 1 ELSE 0 END),
        Total_Anulados       = SUM(CASE WHEN g.Estado_Gasto = 0 THEN 1 ELSE 0 END),
        Monto_Total_Activos  = SUM(CASE WHEN g.Estado_Gasto = 1 THEN g.Importe ELSE 0 END),
        Monto_Total_Anulados = SUM(CASE WHEN g.Estado_Gasto = 0 THEN g.Importe ELSE 0 END)
    FROM Reserva r
    LEFT JOIN Gasto g
        ON g.ID_Reserva = r.ID_Reserva
    WHERE r.ID_Reserva = @ID_Reserva
    GROUP BY r.ID_Reserva, r.Fecha_Reserva;

END
GO

CREATE PROCEDURE SP_Read_CobroReserva
    @ID_Reserva INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que la reserva exista
    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE ID_Reserva = @ID_Reserva)
    BEGIN
        RAISERROR('No existe reserva con ese ID.', 16, 1);
        RETURN;
    END

    -- Un solo SELECT con todo el detalle de cobros
    SELECT
        r.ID_Reserva,
        c.ID_Cobro,
        c.Fecha_Cobro,
        mp.Nombre_MetodoPago,
        g.ID_Gasto,
        g.Fecha_Gasto,
        g.Importe,
        g.Cantidad_Producto,
        p.Nombre_Producto,
        o.Nombre_Origen,
        per.Nombre1_Personal + ' ' + per.Apellido1_Personal AS Personal_Responsable
    FROM Reserva r
    INNER JOIN Gasto g          ON g.ID_Reserva = r.ID_Reserva
    INNER JOIN Cobro_Gasto cg   ON cg.ID_Gasto = g.ID_Gasto
    INNER JOIN Cobro c          ON c.ID_Cobro = cg.ID_Cobro
    INNER JOIN MetodoPago mp    ON mp.ID_MetodoPago = c.Metodo_Cobro
    INNER JOIN Producto p       ON p.ID_Producto = g.Producto_Gasto
    INNER JOIN Origen o         ON o.ID_Origen = g.Origen_Gasto
    INNER JOIN Personal per     ON per.ID_Personal = g.ID_Personal
    WHERE r.ID_Reserva = @ID_Reserva
    ORDER BY c.Fecha_Cobro DESC, g.Fecha_Gasto DESC;
END
GO

CREATE PROCEDURE SP_Read_PedidoResumen
    @ID_Pedido INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ID_Pedido,
        p.Fecha_Pedido,
        p.CUIL_CUIT_Proveedor
    FROM Pedido p
    WHERE p.ID_Pedido = @ID_Pedido;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe pedido con ese ID.', 16, 1);
    END
END
GO

-- Devuelve ID y nombre de cada origen registrado.
CREATE PROCEDURE SP_Read_OrigenLista
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID_Origen, Nombre_Origen FROM Origen;
END;
GO

-- Lista los roles y su descripcion.
CREATE PROCEDURE SP_Read_RolDetalle
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID_Rol, Nombre_Rol, Descripcion_Rol FROM Rol;
END;
GO

-- Muestra las categorias con su descuento asociado.
CREATE PROCEDURE SP_Read_CategoriaDescuento
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID_Categoria, Nombre_Categoria, Descuento_Categoria FROM Categoria;
END;
GO

CREATE PROCEDURE SP_Read_ReservaDetalleCompleto
    @ID_Reserva INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @ID_Reserva IS NULL
    BEGIN
        RAISERROR('Error: El ID de Reserva no puede ser NULL.',16,1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE ID_Reserva = @ID_Reserva)
    BEGIN
        RAISERROR('Error: No existe reserva con ese ID.',16,1);
        RETURN;
    END

    SELECT
        -- Reserva
        r.ID_Reserva,
        r.Fecha_Reserva,
        r.Fecha_Reserva_Inicio,
        r.Fecha_Reserva_Fin,
        r.Fecha_CheckIn,
        r.Fecha_CheckOut,

        -- Titular
        tit.ID_Huesped              AS ID_Titular,
        tit.Cedula_Huesped          AS Cedula_Titular,
        tit.Nombre1_Huesped         AS Nombre1_Titular,
        tit.Apellido1_Huesped       AS Apellido1_Titular,
        tit.Email_Huesped           AS Email_Titular,

        -- Habitacion + Tipo
        hab.ID_Nro_Habitacion,
        hab.Estado_Habitacion,
        th.ID_Tipo_Habitacion,
        th.Nombre_Tipo_Habitacion,
        th.Precio_Habitacion,
        th.Capacidad_Habitacion,

        -- Huespedes asociados via Reserva_Huesped
        rh.ID_Huesped               AS ID_Huesped_Reserva,
        h2.Cedula_Huesped           AS Cedula_Huesped_Reserva,
        h2.Nombre1_Huesped          AS Nombre1_Huesped_Reserva,
        h2.Apellido1_Huesped        AS Apellido1_Huesped_Reserva,
        h2.Email_Huesped            AS Email_Huesped_Reserva
    FROM Reserva r
    INNER JOIN Huesped tit
        ON tit.ID_Huesped = r.Titular_Reserva
    INNER JOIN Habitacion hab
        ON hab.ID_Nro_Habitacion = r.ID_Habitacion
    LEFT JOIN TipoHabitacion th
        ON th.ID_Tipo_Habitacion = hab.Tipo_Habitacion
    LEFT JOIN Reserva_Huesped rh
        ON rh.ID_Reserva = r.ID_Reserva
    LEFT JOIN Huesped h2
        ON h2.ID_Huesped = rh.ID_Huesped
    WHERE r.ID_Reserva = @ID_Reserva
    ORDER BY rh.ID_Huesped;
END
GO

