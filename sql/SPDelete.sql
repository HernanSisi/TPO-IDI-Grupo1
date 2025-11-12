CREATE PROCEDURE SP_ReservaHuesped_Delete
    @ID_Reserva INT,
    @ID_Huesped INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Eliminar la relación entre reserva y huésped
    DELETE FROM Reserva_Huesped
    WHERE ID_Reserva = @ID_Reserva 
      AND ID_Huesped = @ID_Huesped;
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe esa relación entre reserva y huésped.', 16, 1);
    END
END;
GO

CREATE PROCEDURE SP_CobroGasto_Delete
    @ID_Cobro INT,
    @ID_Gasto INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que exista la relación
    IF NOT EXISTS (
        SELECT 1 
        FROM Cobro_Gasto
        WHERE ID_Cobro = @ID_Cobro
          AND ID_Gasto = @ID_Gasto
    )
    BEGIN
        RAISERROR('No existe esa relación entre cobro y gasto.', 16, 1);
        RETURN;
    END

    -- Eliminar la relación
    DELETE FROM Cobro_Gasto
    WHERE ID_Cobro = @ID_Cobro
      AND ID_Gasto = @ID_Gasto;

    PRINT 'Relación cobro-gasto eliminada correctamente.';
END
GO

CREATE PROCEDURE SP_DeleteRol
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
GO

CREATE PROCEDURE SP_DeleteOrigen
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
GO

CREATE PROCEDURE SP_DeleteCategoria
    @ID_Categoria INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Categoria WHERE ID_Categoria = @ID_Categoria)
        BEGIN
            RAISERROR('No existe una categoría con ese ID.', 16, 1);
            RETURN;
        END

        DELETE FROM Categoria WHERE ID_Categoria = @ID_Categoria;
    END TRY
    BEGIN CATCH
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END;
GO