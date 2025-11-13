CREATE PROCEDURE SP_Update_Proveedor
    @CUIL_CUIT_Proveedor VARCHAR(15),
	@Razon_Social_Proveedor VARCHAR(150) = NULL,
    @Telefono_Proveedor VARCHAR(20) = NULL,
    @Email_Proveedor VARCHAR(100) = NULL
AS 
BEGIN
    SET NOCOUNT ON;
    
    IF @Email_Proveedor is NOT NULL AND EXISTS (SELECT 1 FROM Proveedor WHERE Email_Proveedor = @Email_Proveedor)
    BEGIN
        RAISERROR ('Error: el email esta asignado a otro proveedor', 16, 1);
        RETURN;
    END

    UPDATE Proveedor
    SET
        Razon_Social_Proveedor = COALESCE(@Razon_Social_Proveedor, Razon_Social_Proveedor),
        Telefono_Proveedor = COALESCE(@Telefono_Proveedor, Telefono_Proveedor),
        Email_Proveedor = COALESCE(@Email_Proveedor, Email_Proveedor)
    WHERE CUIL_CUIT_Proveedor = @CUIL_CUIT_Proveedor;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe tipo de habitacion con ese ID.', 16, 1);
    END
END;

CREATE PROCEDURE SP_Update_Huesped
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
        IF NOT EXISTS (SELECT 1 FROM Huesped WHERE ID_Huesped = @ID_Huesped)
        BEGIN
            RAISERROR('No existe huesped con ese ID.', 16, 1);
            RETURN;
        END

        IF @Email_Huesped IS NOT NULL
        BEGIN
            SELECT @EmailCount = COUNT(*) FROM Personal WHERE Email_Personal = @Email_Huesped;
            IF @EmailCount > 0
            BEGIN
                RAISERROR('El email ya existe en la tabla Personal.', 16, 1);
                RETURN;
            END
        END

        IF @ID_Categoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Categoria WHERE ID_Categoria = @ID_Categoria)
        BEGIN
            RAISERROR('La categoria especificada no existe.', 16, 1);
            RETURN;
        END

        UPDATE Huesped
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

CREATE PROCEDURE SP_Update_Personal
    @ID_Personal INT,
    @Email_Personal VARCHAR(100) = NULL,
    @Nombre1_Personal VARCHAR(50) = NULL,
    @Nombre2_Personal VARCHAR(50) = NULL,
    @Apellido1_Personal VARCHAR(50) = NULL,
    @Apellido2_Personal VARCHAR(50) = NULL,
    @Fecha_Nacimiento_Personal DATE = NULL,
    @ID_Rol INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @EmailCount INT;
    
    -- Solo verificar email en Huesped si se estA¡ intentando cambiar
    IF @Email_Personal IS NOT NULL
    BEGIN
        SELECT @EmailCount = COUNT(*) 
        FROM Huesped 
        WHERE Email_Huesped = @Email_Personal;
        
        IF @EmailCount > 0
        BEGIN
            RAISERROR('El email ya existe en la tabla Huesped.', 16, 1);
            RETURN;
        END
    END
    
    -- Verificar que el rol exista si se estA¡ intentando cambiar
    IF @ID_Rol IS NOT NULL
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Rol WHERE ID_Rol = @ID_Rol)
        BEGIN
            RAISERROR('El rol especificado no existe.', 16, 1);
            RETURN;
        END
    END
    
    -- UPDATE manteniendo valores actuales si el parA¡metro es NULL
    UPDATE Personal
    SET 
        Email_Personal = COALESCE(@Email_Personal, Email_Personal),
        Nombre1_Personal = COALESCE(@Nombre1_Personal, Nombre1_Personal),
        Nombre2_Personal = COALESCE(@Nombre2_Personal, Nombre2_Personal),
        Apellido1_Personal = COALESCE(@Apellido1_Personal, Apellido1_Personal),
        Apellido2_Personal = COALESCE(@Apellido2_Personal, Apellido2_Personal),
        Fecha_Nacimiento_Personal = COALESCE(@Fecha_Nacimiento_Personal, Fecha_Nacimiento_Personal),
        ID_Rol = COALESCE(@ID_Rol, ID_Rol)
    WHERE ID_Personal = @ID_Personal;
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe personal con ese ID.', 16, 1);
    END
END;

CREATE PROCEDURE SP_Update_MetodoPago
    @ID_MetodoPago INT,
    @Nombre_MetodoPago VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE MetodoPago
    SET 
        Nombre_MetodoPago = COALESCE(@Nombre_MetodoPago, Nombre_MetodoPago)
    WHERE ID_MetodoPago = @ID_MetodoPago;
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe metodo de pago con ese ID.', 16, 1);
    END
END;


CREATE PROCEDURE SP_Update_Producto
    @ID_Producto INT,
    @Nombre_Producto VARCHAR(100) = NULL,
    @Precio_Unidad_Producto DECIMAL(10,2) = NULL,
    @Stock_Alerta INT = NULL,
    @Stock_Producto INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- UPDATE manteniendo valores actuales si el parA¡metro es NULL
    UPDATE Producto
    SET 
        Nombre_Producto = COALESCE(@Nombre_Producto, Nombre_Producto),
        Precio_Unidad_Producto = COALESCE(@Precio_Unidad_Producto, Precio_Unidad_Producto),
        Stock_Alerta = COALESCE(@Stock_Alerta, Stock_Alerta),
        Stock_Producto = COALESCE(@Stock_Producto, Stock_Producto)
    WHERE ID_Producto = @ID_Producto;
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe producto con ese ID.', 16, 1);
    END
END;

CREATE PROCEDURE SP_Update_TipoHabitacion
    @ID_Tipo_Habitacion INT,
    @Nombre_Tipo_Habitacion VARCHAR(50) = NULL,
    @Precio_Habitacion DECIMAL(10,2) = NULL,
    @Capacidad_Habitacion INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- UPDATE manteniendo valores actuales si el parA¡metro es NULL
    UPDATE TipoHabitacion
    SET 
        Nombre_Tipo_Habitacion = COALESCE(@Nombre_Tipo_Habitacion, Nombre_Tipo_Habitacion),
        Precio_Habitacion = COALESCE(@Precio_Habitacion, Precio_Habitacion),
        Capacidad_Habitacion = COALESCE(@Capacidad_Habitacion, Capacidad_Habitacion)
    WHERE ID_Tipo_Habitacion = @ID_Tipo_Habitacion;
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe tipo de habitaciA3n con ese ID.', 16, 1);
    END
END;

CREATE PROCEDURE SP_Update_Habitacion
    @ID_Nro_Habitacion int,
    @Estado_Habitacion bit,
    @Tipo_Habitacion int
AS
BEGIN
        IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE Tipo_Habitacion = @Tipo_Habitacion)
        BEGIN
            RAISERROR('El tipo de habitacion especificado no existe.', 16, 1);
            RETURN;
        END
    UPDATE Habitacion 
    SET
        Estado_Habitacion = COALESCE(@Estado_Habitacion, Estado_Habitacion),
        Tipo_Habitacion = COALESCE(@Tipo_Habitacion, Tipo_Habitacion)
    WHERE ID_Nro_Habitacion = @ID_Nro_Habitacion;
END;


