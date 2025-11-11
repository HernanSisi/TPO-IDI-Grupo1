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



