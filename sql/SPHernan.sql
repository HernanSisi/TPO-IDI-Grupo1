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