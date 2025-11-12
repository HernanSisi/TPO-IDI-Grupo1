-- Procedimiento almacenado para insertar un nuevo registro en la tabla PERSONAL
-- Verifica que el email no exista en la tabla HUESPED antes de insertar

CREATE PROCEDURE SP_Personal_Insert
    @Cedula_Personal VARCHAR(50),
    @Email_Personal VARCHAR(100),
    @Nombre1_Personal VARCHAR(50),
    @Nombre2_Personal VARCHAR(50) = NULL,
    @Apellido1_Personal VARCHAR(50),
    @Apellido2_Personal VARCHAR(50) = NULL,
    @Fecha_Nacimiento_Personal DATE,
    @ID_Rol INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @EmailCount INT;
    
    -- Verificar si el email existe en HUESPED
    SELECT @EmailCount = COUNT(*) 
    FROM HUESPED 
    WHERE Email_Huesped = @Email_Personal;
    
    IF @EmailCount = 0
    BEGIN
        -- Verificar que el rol exista
        IF NOT EXISTS (SELECT 1 FROM Rol WHERE ID_Rol = @ID_Rol)
        BEGIN
            RAISERROR('El rol especificado no existe.', 16, 1);
            RETURN;
        END
        
        INSERT INTO Personal (
            Cedula_Personal,
            Email_Personal,
            Nombre1_Personal,
            Nombre2_Personal,
            Apellido1_Personal,
            Apellido2_Personal,
            Fecha_Nacimiento_Personal,
            ID_Rol
        )
        VALUES (
            @Cedula_Personal,
            @Email_Personal,
            @Nombre1_Personal,
            @Nombre2_Personal,
            @Apellido1_Personal,
            @Apellido2_Personal,
            @Fecha_Nacimiento_Personal,
            @ID_Rol
        );
    END
    ELSE
    BEGIN
        RAISERROR('El email ya existe en la tabla HUESPED.', 16, 1);
    END;
END;
GO

EXEC SP_Personal_Insert
    @Cedula_Personal = '27-87654321-0',
    @Email_Personal = 'maria.lopez@hotel.com',
    @Nombre1_Personal = 'María',
    @Nombre2_Personal = NULL,
    @Apellido1_Personal = 'López',
    @Apellido2_Personal = NULL,
    @Fecha_Nacimiento_Personal = '1995-08-22',
    @ID_Rol = 2;

EXEC SP_Personal_Insert
    @Cedula_Personal = '20202020201',
    @Email_Personal = 'lionelmessi@gmail.com',
    @Nombre1_Personal = 'Lionel',
    @Nombre2_Personal = NULL,
    @Apellido1_Personal = 'Messi',
    @Apellido2_Personal = NULL,
    @Fecha_Nacimiento_Personal = '1995-08-21',
    @ID_Rol = 1;

go
-- Procedimiento almacenado para actualizar un registro en la tabla PERSONAL
-- Verifica que el email no exista en la tabla HUESPED antes de actualizar
CREATE PROCEDURE SP_Personal_Update
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
    
    -- Solo verificar email en HUESPED si se está intentando cambiar
    IF @Email_Personal IS NOT NULL
    BEGIN
        SELECT @EmailCount = COUNT(*) 
        FROM HUESPED 
        WHERE Email_Huesped = @Email_Personal;
        
        IF @EmailCount > 0
        BEGIN
            RAISERROR('El email ya existe en la tabla HUESPED.', 16, 1);
            RETURN;
        END
    END
    
    -- Verificar que el rol exista si se está intentando cambiar
    IF @ID_Rol IS NOT NULL
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Rol WHERE ID_Rol = @ID_Rol)
        BEGIN
            RAISERROR('El rol especificado no existe.', 16, 1);
            RETURN;
        END
    END
    
    -- UPDATE manteniendo valores actuales si el parámetro es NULL
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
GO

select * from personal;


EXEC SP_Personal_Update
    @ID_Personal = 12,
    @Email_Personal = 'mlopez@macacookie.com';



-- SP insertar metodo de pago
GO
CREATE PROCEDURE SP_MetodoPago_Insert
    @Nombre_MetodoPago VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Normalizo básico (opcional pero útil)
        SET @Nombre_MetodoPago = LTRIM(RTRIM(@Nombre_MetodoPago));

        IF @Nombre_MetodoPago = ''
        BEGIN
            RAISERROR('El nombre del método de pago no puede ser vacío.', 16, 1);
            RETURN;
        END

        INSERT INTO MetodoPago (Nombre_MetodoPago)
        VALUES (@Nombre_MetodoPago);

        -- Devuelvo el ID generado
        SELECT CAST(SCOPE_IDENTITY() AS INT) AS ID_MetodoPago;
    END TRY
    BEGIN CATCH
        -- Reenvío el error (incluye violación de UNIQUE si hay duplicado)
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END
GO
EXEC SP_MetodoPago_Insert @Nombre_MetodoPago = 'Tarjeta de Crédito';
EXEC SP_MetodoPago_Insert @Nombre_MetodoPago = '';

go
-- SP actualizar metodo de pago
CREATE PROCEDURE SP_MetodoPago_Update
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
        RAISERROR('No existe método de pago con ese ID.', 16, 1);
    END
END;
GO

-- Cambiar el nombre del método de pago con ID 1
EXEC SP_MetodoPago_Update 
    @ID_MetodoPago = 1,
    @Nombre_MetodoPago = 'Tarjeta de Crédito';

-- Otro ejemplo
EXEC SP_MetodoPago_Update 
    @ID_MetodoPago = 2,
    @Nombre_MetodoPago = 'Efectivo';

go

-- SP Actualizar producto 
CREATE PROCEDURE SP_Producto_Update
    @ID_Producto INT,
    @Nombre_Producto VARCHAR(100) = NULL,
    @Precio_Unidad_Producto DECIMAL(10,2) = NULL,
    @Stock_Alerta INT = NULL,
    @Stock_Producto INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- UPDATE manteniendo valores actuales si el parámetro es NULL
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
GO
-- Cambiar solo el precio
EXEC SP_Producto_Update 
    @ID_Producto = 1,
    @Precio_Unidad_Producto = 150.50;

-- Cambiar nombre y stock
EXEC SP_Producto_Update 
    @ID_Producto = 1,
    @Nombre_Producto = 'Shampoo Premium',
    @Stock_Producto = 100;

-- Cambiar stock de alerta
EXEC SP_Producto_Update 
    @ID_Producto = 1,
    @Stock_Alerta = 10;

-- Cambiar varios campos
EXEC SP_Producto_Update 
    @ID_Producto = 1,
    @Nombre_Producto = 'Jabón Líquido',
    @Precio_Unidad_Producto = 85.00,
    @Stock_Producto = 50;


    