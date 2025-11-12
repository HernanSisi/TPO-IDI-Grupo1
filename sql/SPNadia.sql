-- PROCEDIMIENTOS ALMACENADOS.

-- Para categoría: READ y DELETE

CREATE PROCEDURE SP_ReadCategoria
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID_Categoria, Nombre_Categoria, Descuento_Categoria FROM Categoria;
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


-- Rol: READ y DELETE

CREATE PROCEDURE SP_ReadRol
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID_Rol, Nombre_Rol, Descripcion_Rol FROM Rol;
END;
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

-- Origen: READ y DELETE

CREATE PROCEDURE SP_ReadOrigen
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID_Origen, Nombre_Origen FROM Origen;
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

-- HUESPED: INSERT y UPDATE

CREATE PROCEDURE SP_InsertHuesped
    @Cedula_Huesped VARCHAR(50),
    @Estado_Huesped BIT = 1,
    @Email_Huesped VARCHAR(100),
    @Nombre1_Huesped VARCHAR(50),
    @Nombre2_Huesped VARCHAR(50) = NULL,
    @Apellido1_Huesped VARCHAR(50),
    @Apellido2_Huesped VARCHAR(50) = NULL,
    @Fecha_Nacimiento_Huesped DATE,
    @ID_Categoria INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EmailCount INT;

    BEGIN TRY
        -- Verificar email no exista en Personal
        SELECT @EmailCount = COUNT(*) FROM Personal WHERE Email_Personal = @Email_Huesped;
        IF @EmailCount > 0
        BEGIN
            RAISERROR('El email ya existe en la tabla PERSONAL.', 16, 1);
            RETURN;
        END

        -- Verificar categoría válida
        IF @ID_Categoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Categoria WHERE ID_Categoria = @ID_Categoria)
        BEGIN
            RAISERROR('La categoría especificada no existe.', 16, 1);
            RETURN;
        END

        INSERT INTO HUESPED (
            Cedula_Huesped, Estado_Huesped, Email_Huesped,
            Nombre1_Huesped, Nombre2_Huesped, Apellido1_Huesped, Apellido2_Huesped,
            Fecha_Nacimiento_Huesped, ID_Categoria
        )
        VALUES (
            @Cedula_Huesped, @Estado_Huesped, @Email_Huesped,
            @Nombre1_Huesped, @Nombre2_Huesped, @Apellido1_Huesped, @Apellido2_Huesped,
            @Fecha_Nacimiento_Huesped, @ID_Categoria
        );
    END TRY
    BEGIN CATCH
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END;
GO


CREATE PROCEDURE SP_UpdateHuesped
    @ID_Huesped INT,
    @Email_Huesped VARCHAR(100) = NULL,
    @Estado_Huesped BIT = NULL,
    @Nombre1_Huesped VARCHAR(50) = NULL,
    @Nombre2_Huesped VARCHAR(50) = NULL,
    @Apellido1_Huesped VARCHAR(50) = NULL,
    @Apellido2_Huesped VARCHAR(50) = NULL,
    @Fecha_Nacimiento_Huesped DATE = NULL,
    @ID_Categoria INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EmailCount INT;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM HUESPED WHERE ID_Huesped = @ID_Huesped)
        BEGIN
            RAISERROR('No existe huésped con ese ID.', 16, 1);
            RETURN;
        END

        IF @Email_Huesped IS NOT NULL
        BEGIN
            SELECT @EmailCount = COUNT(*) FROM Personal WHERE Email_Personal = @Email_Huesped;
            IF @EmailCount > 0
            BEGIN
                RAISERROR('El email ya existe en la tabla PERSONAL.', 16, 1);
                RETURN;
            END
        END

        IF @ID_Categoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Categoria WHERE ID_Categoria = @ID_Categoria)
        BEGIN
            RAISERROR('La categoría especificada no existe.', 16, 1);
            RETURN;
        END

        UPDATE HUESPED
        SET 
            Email_Huesped = COALESCE(@Email_Huesped, Email_Huesped),
            Estado_Huesped = COALESCE(@Estado_Huesped, Estado_Huesped),
            Nombre1_Huesped = COALESCE(@Nombre1_Huesped, Nombre1_Huesped),
            Nombre2_Huesped = COALESCE(@Nombre2_Huesped, Nombre2_Huesped),
            Apellido1_Huesped = COALESCE(@Apellido1_Huesped, Apellido1_Huesped),
            Apellido2_Huesped = COALESCE(@Apellido2_Huesped, Apellido2_Huesped),
            Fecha_Nacimiento_Huesped = COALESCE(@Fecha_Nacimiento_Huesped, Fecha_Nacimiento_Huesped),
            ID_Categoria = COALESCE(@ID_Categoria, ID_Categoria)
        WHERE ID_Huesped = @ID_Huesped;

    END TRY
    BEGIN CATCH
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END;
GO



