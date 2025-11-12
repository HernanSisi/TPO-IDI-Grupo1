GO
CREATE PROCEDURE SP_InsertarGasto
    @Importe DECIMAL(10,2),
    @Fecha_Gasto DATETIME = NULL,
    @Producto_Gasto INT,
    @Cantidad_Producto INT,
    @ID_Personal INT,
    @ID_Reserva INT,
        @Origen_Gasto INT
    AS
    BEGIN
        SET NOCOUNT ON;

        IF @Importe IS NULL OR @Producto_Gasto IS NULL OR @Cantidad_Producto IS NULL
            OR @ID_Personal IS NULL OR @ID_Reserva IS NULL OR @Origen_Gasto IS NULL
        BEGIN
            RAISERROR('Error: Faltan parametros obligatorios (no pueden ser NULL).',16,1);
            RETURN;
        END

        IF @Importe < 0
        BEGIN
            RAISERROR('Error: Importe debe ser >= 0.',16,1);
            RETURN;
        END

        IF @Cantidad_Producto <= 0
        BEGIN
            RAISERROR('Error: Cantidad_Producto debe ser > 0.',16,1);
            RETURN;
        END

        IF @Fecha_Gasto IS NULL
            SET @Fecha_Gasto = GETDATE();

        IF NOT EXISTS(SELECT 1 FROM Producto WHERE ID_Producto = @Producto_Gasto)
        BEGIN
            RAISERROR('Error: Producto indicado no existe.',16,1);
            RETURN;
        END

        IF NOT EXISTS(SELECT 1 FROM Personal WHERE ID_Personal = @ID_Personal)
        BEGIN
            RAISERROR('Error: Personal indicado no existe.',16,1);
            RETURN;
        END

        IF NOT EXISTS(SELECT 1 FROM Reserva WHERE ID_Reserva = @ID_Reserva)
        BEGIN
            RAISERROR('Error: Reserva indicada no existe.',16,1);
            RETURN;
        END

        IF NOT EXISTS(SELECT 1 FROM Origen WHERE ID_Origen = @Origen_Gasto)
        BEGIN
            RAISERROR('Error: Origen indicado no existe.',16,1);
            RETURN;
        END

        BEGIN TRANSACTION;
            INSERT INTO Gasto
                (Importe, Fecha_Gasto, Producto_Gasto, Cantidad_Producto, ID_Personal, ID_Reserva, Origen_Gasto)
            VALUES
                (@Importe, @Fecha_Gasto, @Producto_Gasto, @Cantidad_Producto, @ID_Personal, @ID_Reserva, @Origen_Gasto);
        COMMIT TRANSACTION;

        RETURN 0;
    END;

GO

CREATE PROCEDURE sp_InsertarCobroGasto
    @ID_Cobro INT,
    @ID_Gasto INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @ID_Cobro IS NULL OR @ID_Gasto IS NULL
        BEGIN
            RAISERROR('Error: Faltan parametros obligatorios (no pueden ser NULL).',16,1);
            RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Cobro WHERE ID_Cobro = @ID_Cobro)
    BEGIN
        RAISERROR ('Error: El cobro indicado no existe', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Gasto WHERE ID_Gasto = @ID_Gasto)
    BEGIN
        RAISERROR ('Error: El gasto indicano no existe.', 16, 1);
        RETURN;
    END

    INSERT INTO Cobro_Gasto 
        (ID_Cobro, ID_Gasto)
    VALUES 
        (@ID_Cobro, @ID_Gasto);

END

GO

CREATE PROCEDURE SP_InsertarPedidoProducto
    @ID_Pedido INT,
    @ID_Producto INT,
    @Cantidad_Producto INT,
    @Costo_unidad DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    IF @ID_Pedido IS NULL OR @ID_Producto IS NULL OR @Cantidad_Producto IS NULL OR @Costo_unidad IS NULL
    BEGIN
        RAISERROR ('Error: Ninguno de los campos puede ser nulo.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Pedido WHERE ID_Pedido = @ID_Pedido)
    BEGIN
        RAISERROR ('Error: El Pedido indicado no existe.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Producto WHERE ID_Producto = @ID_Producto)
    BEGIN
        RAISERROR ('Error: El Producto indicado no existe.', 16, 1);
        RETURN;
    END

    IF @Cantidad_Producto <= 0
    BEGIN
        RAISERROR ('Error: La cantidad del producto debe ser mayor que cero.', 16, 1);
        RETURN;
    END

    IF @Costo_unidad < 0
    BEGIN
        RAISERROR ('Error: El costo por unidad no puede ser un valor negativo.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Pedido_Producto WHERE ID_Pedido = @ID_Pedido AND ID_Producto = @ID_Producto)
    BEGIN
        RAISERROR ('Error: El producto ya ha sido agregado a este pedido.', 16, 1);
        RETURN;
    END

    INSERT INTO Pedido_Producto 
        (ID_Pedido, ID_Producto, Cantidad_Producto, Costo_unidad)
    VALUES 
        (@ID_Pedido, @ID_Producto, @Cantidad_Producto, @Costo_unidad);

END

GO

CREATE PROCEDURE sp_InsertarPedido
    @CUIL_CUIT_Proveedor VARCHAR(15),
    @Fecha_Pedido DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @CUIL_CUIT_Proveedor IS NULL OR @CUIL_CUIT_Proveedor = ''
    BEGIN
        RAISERROR ('Error: El CUIL/CUIT del proveedor no puede estar vacío.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE CUIL_CUIT_Proveedor = @CUIL_CUIT_Proveedor)
    BEGIN
        RAISERROR ('Error: El proveedor indicado no existe.', 16, 1);
        RETURN;
    END

    IF @Fecha_Pedido IS NULL
    BEGIN
        SET @Fecha_Pedido = GETDATE();
    END

    INSERT INTO Pedido 
        (CUIL_CUIT_Proveedor, Fecha_Pedido)
    VALUES 
        (@CUIL_CUIT_Proveedor, @Fecha_Pedido);

END

GO

CREATE PROCEDURE sp_InsertarCobro
    @ID_MetodoPago INT,
    @Fecha_Cobro DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @ID_MetodoPago IS NULL
    BEGIN
        RAISERROR ('Error: El método de pago no puede estar vacío.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM MetodoPago WHERE ID_MetodoPago = @ID_MetodoPago)
    BEGIN
        RAISERROR ('Error: El método de pago indicado no existe.', 16, 1);
        RETURN;
    END

    IF @Fecha_Cobro IS NULL
    BEGIN
        SET @Fecha_Cobro = GETDATE();
    END

    INSERT INTO Cobro 
        (Fecha_Cobro, Metodo_Cobro)
    VALUES 
        (@Fecha_Cobro, @ID_MetodoPago);

END

GO

CREATE PROCEDURE sp_InsertarReservaHuesped
    @ID_Reserva INT,
    @ID_Huesped INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @ID_Reserva IS NULL
    BEGIN
        RAISERROR ('Error: El ID de Reserva no puede estar vacío.', 16, 1);
        RETURN;
    END

    IF @ID_Huesped IS NULL
    BEGIN
        RAISERROR ('Error: El ID de Huésped no puede estar vacío.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE ID_Reserva = @ID_Reserva)
    BEGIN
        RAISERROR ('Error: La Reserva indicada no existe.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM HUESPED WHERE ID_Huesped = @ID_Huesped)
    BEGIN
        RAISERROR ('Error: El Huésped indicado no existe.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Reserva_Huesped WHERE ID_Reserva = @ID_Reserva AND ID_Huesped = @ID_Huesped)
    BEGIN
        RAISERROR ('Error: Este Huésped ya está asignado a esta Reserva.', 16, 1);
        RETURN;
    END

    INSERT INTO Reserva_Huesped 
        (ID_Reserva, ID_Huesped)
    VALUES 
        (@ID_Reserva, @ID_Huesped);

END


GO

