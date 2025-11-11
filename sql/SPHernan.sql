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

        -- Validaciones de NULL
        IF @Importe IS NULL OR @Producto_Gasto IS NULL OR @Cantidad_Producto IS NULL
            OR @ID_Personal IS NULL OR @ID_Reserva IS NULL OR @Origen_Gasto IS NULL
        BEGIN
            RAISERROR('Faltan parametros obligatorios (no pueden ser NULL).',16,1);
            RETURN 1;
        END

        -- Validaciones de valores
        IF @Importe < 0
        BEGIN
            RAISERROR('Importe debe ser >= 0.',16,1);
            RETURN 2;
        END

        IF @Cantidad_Producto <= 0
        BEGIN
            RAISERROR('Cantidad_Producto debe ser > 0.',16,1);
            RETURN 3;
        END

        IF @Fecha_Gasto IS NULL
            SET @Fecha_Gasto = GETDATE();

        -- Verificar existencia de claves foraneas
        IF NOT EXISTS(SELECT 1 FROM dbo.Producto WHERE ID_Producto = @Producto_Gasto)
        BEGIN
            RAISERROR('Producto indicado no existe.',16,1);
            RETURN 11;
        END

        IF NOT EXISTS(SELECT 1 FROM dbo.Personal WHERE ID_Personal = @ID_Personal)
        BEGIN
            RAISERROR('Personal indicado no existe.',16,1);
            RETURN 12;
        END

        IF NOT EXISTS(SELECT 1 FROM dbo.Reserva WHERE ID_Reserva = @ID_Reserva)
        BEGIN
            RAISERROR('Reserva indicada no existe.',16,1);
            RETURN 13;
        END

        IF NOT EXISTS(SELECT 1 FROM dbo.Origen WHERE ID_Origen = @Origen_Gasto)
        BEGIN
            RAISERROR('Origen indicado no existe.',16,1);
            RETURN 14;
        END

        -- Insertar (Estado_Gasto usa el DEFAULT definido en la tabla)
        BEGIN TRANSACTION;
            INSERT INTO dbo.Gasto
                (Importe, Fecha_Gasto, Producto_Gasto, Cantidad_Producto, ID_Personal, ID_Reserva, Origen_Gasto)
            VALUES
                (@Importe, @Fecha_Gasto, @Producto_Gasto, @Cantidad_Producto, @ID_Personal, @ID_Reserva, @Origen_Gasto);
        COMMIT TRANSACTION;

        RETURN 0;
    END;
