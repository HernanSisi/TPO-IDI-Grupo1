CREATE PROCEDURE SP_Delete_Reserva_Huesped
    @ID_Reserva INT,
    @ID_Huesped INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Eliminar la relaciA3n entre reserva y huA©sped
    DELETE FROM Reserva_Huesped
    WHERE ID_Reserva = @ID_Reserva 
      AND ID_Huesped = @ID_Huesped;
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe esa relacion entre reserva y Huesped.', 16, 1);
    END
END;

CREATE PROCEDURE SP_Delete_Cobro_Gasto
    @ID_Cobro INT,
    @ID_Gasto INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que exista la relaciA3n
    IF NOT EXISTS (
        SELECT 1 
        FROM Cobro_Gasto
        WHERE ID_Cobro = @ID_Cobro
          AND ID_Gasto = @ID_Gasto
    )
    BEGIN
        RAISERROR('No existe esa relacion entre cobro y gasto.', 16, 1);
        RETURN;
    END

    -- Eliminar la relaciA3n
    DELETE FROM Cobro_Gasto
    WHERE ID_Cobro = @ID_Cobro
      AND ID_Gasto = @ID_Gasto;

    PRINT 'Relacion cobro-gasto eliminada correctamente.';
END

CREATE PROCEDURE SP_Delete_Rol
    @ID_Rol INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Rol WHERE ID_Rol = @ID_Rol)
        BEGIN
            RAISERROR('No existe un rol con ese ID.', 16, 1);
            RETURN;
        END

        DELETE FROM Rol WHERE ID_Rol = @ID_Rol;
    END TRY
    BEGIN CATCH
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END;

CREATE PROCEDURE SP_Delete_Origen
    @ID_Origen INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Origen WHERE ID_Origen = @ID_Origen)
        BEGIN
            RAISERROR('No existe un origen con ese ID.', 16, 1);
            RETURN;
        END

        DELETE FROM Origen WHERE ID_Origen = @ID_Origen;
    END TRY
    BEGIN CATCH
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END;

CREATE PROCEDURE SP_Delete_Categoria
    @ID_Categoria INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Categoria WHERE ID_Categoria = @ID_Categoria)
        BEGIN
            RAISERROR('No existe una categoria con ese ID.', 16, 1);
            RETURN;
        END

        DELETE FROM Categoria WHERE ID_Categoria = @ID_Categoria;
    END TRY
    BEGIN CATCH
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END;
