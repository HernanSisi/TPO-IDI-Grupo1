CREATE PROCEDURE SP_Insert_Gasto
    @Fecha_Gasto DATETIME = NULL,
    @Producto_Gasto INT,
    @Cantidad_Producto INT,
    @ID_Personal INT,
    @ID_Reserva INT,
        @Origen_Gasto INT
    AS
    BEGIN
        SET NOCOUNT ON;

        IF @Producto_Gasto IS NULL OR @Cantidad_Producto IS NULL
            OR @ID_Personal IS NULL OR @ID_Reserva IS NULL OR @Origen_Gasto IS NULL
        BEGIN
            RAISERROR('Error: Faltan parametros obligatorios (no pueden ser NULL).',16,1);
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

        Declare @PrecioUnidad DECIMAL(10,2);
        SET @PrecioUnidad = (select precio_unidad_producto from producto where id_producto = @Producto_Gasto);

        BEGIN TRANSACTION;
            INSERT INTO Gasto
                (Importe, Fecha_Gasto, Producto_Gasto, Cantidad_Producto, ID_Personal, ID_Reserva, Origen_Gasto)
            VALUES
                (@PrecioUnidad * @Cantidad_Producto, @Fecha_Gasto, @Producto_Gasto, @Cantidad_Producto, @ID_Personal, @ID_Reserva, @Origen_Gasto);
        COMMIT TRANSACTION;

        RETURN 0;
    END;
GO

CREATE PROCEDURE SP_Insert_Cobro_Gasto
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

CREATE PROCEDURE SP_Insert_Pedido_Producto
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

CREATE PROCEDURE SP_Insert_Pedido
    @CUIL_CUIT_Proveedor VARCHAR(15),
    @Fecha_Pedido DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @CUIL_CUIT_Proveedor IS NULL OR @CUIL_CUIT_Proveedor = ''
    BEGIN
        RAISERROR ('Error: El CUIL/CUIT del proveedor no puede estar vacio.', 16, 1);
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

CREATE PROCEDURE SP_Insert_Cobro
    @ID_MetodoPago INT,
    @Fecha_Cobro DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @ID_MetodoPago IS NULL
    BEGIN
        RAISERROR ('Error: El metodo de pago no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM MetodoPago WHERE ID_MetodoPago = @ID_MetodoPago)
    BEGIN
        RAISERROR ('Error: El metodo de pago indicado no existe.', 16, 1);
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

CREATE PROCEDURE SP_Insert_Reserva_Huesped
    @ID_Reserva INT,
    @ID_Huesped INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @ID_Reserva IS NULL
    BEGIN
        RAISERROR ('Error: El ID de Reserva no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF @ID_Huesped IS NULL
    BEGIN
        RAISERROR ('Error: El ID de Huesped no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE ID_Reserva = @ID_Reserva)
    BEGIN
        RAISERROR ('Error: La Reserva indicada no existe.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Huesped WHERE ID_Huesped = @ID_Huesped)
    BEGIN
        RAISERROR ('Error: El Huesped indicado no existe.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Reserva_Huesped WHERE ID_Reserva = @ID_Reserva AND ID_Huesped = @ID_Huesped)
    BEGIN
        RAISERROR ('Error: Este Huesped ya esta asignado a esta Reserva.', 16, 1);
        RETURN;
    END

    DECLARE @LimiteHabitacion INT;
    SELECT @LimiteHabitacion = th.Capacidad_Habitacion
    FROM Habitacion hab
    INNER JOIN TipoHabitacion th ON th.ID_Tipo_Habitacion = hab.Tipo_Habitacion
    INNER JOIN Reserva r ON r.ID_Habitacion = hab.ID_Nro_Habitacion
    WHERE r.ID_Reserva = @ID_Reserva;

    DECLARE @CantidadHuespedes INT;
    SELECT @CantidadHuespedes = COUNT(*) + 1
    FROM Reserva_Huesped
    WHERE ID_Reserva = @ID_Reserva;

    IF @CantidadHuespedes >= @LimiteHabitacion
    BEGIN
        RAISERROR ('Error: Se ha alcanzado el limite de huespedes para esta habitacion.', 16, 1);
        RETURN;
    END   
    INSERT INTO Reserva_Huesped 
        (ID_Reserva, ID_Huesped)
    VALUES 
        (@ID_Reserva, @ID_Huesped);

END
GO

CREATE PROCEDURE SP_Insert_Reserva
    @Titular_Reserva INT,
    @ID_Habitacion INT,
    @Fecha_Reserva_Inicio DATETIME,
    @Fecha_Reserva_Fin DATETIME,
    @Fecha_Reserva DATETIME = NULL,
    @Fecha_CheckIn DATETIME = NULL,
    @Fecha_CheckOut DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Titular_Reserva IS NULL or @ID_Habitacion IS NULL OR @Fecha_Reserva_Inicio IS NULL OR @Fecha_Reserva_Fin IS NULL
    BEGIN
        RAISERROR ('Error: Los campos Habitacion, Fecha de inicio de la reserva, fecha de fin de la reserva o titular no pueden estar vacios.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Huesped WHERE ID_Huesped = @Titular_Reserva)
    BEGIN
        RAISERROR ('Error: El Huesped titular indicado no existe.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE ID_Nro_Habitacion = @ID_Habitacion)
    BEGIN
        RAISERROR ('Error: La Habitacion indicada no existe.', 16, 1);
        RETURN;
    END

-- Esta activa la habitacion
    IF NOT EXISTS (
        SELECT 1 
        FROM Habitacion 
        WHERE ID_Nro_Habitacion = @ID_Habitacion
          AND Estado_Habitacion = 1
    )
    BEGIN
        RAISERROR ('Error: La Habitacion indicada no esta activa.', 16, 1);
        RETURN;
    END
    
    IF @Fecha_Reserva_Fin <= @Fecha_Reserva_Inicio
    BEGIN
        RAISERROR ('Error: La fecha de fin de reserva debe ser posterior a la fecha de inicio.', 16, 1);
        RETURN;
    END

    IF @Fecha_CheckIn IS NOT NULL AND @Fecha_CheckOut IS NOT NULL AND @Fecha_CheckOut <= @Fecha_CheckIn
    BEGIN
        RAISERROR ('Error: La fecha de Check-Out debe ser posterior a la fecha de Check-In.', 16, 1);
        RETURN;
    END

    IF @Fecha_Reserva IS NULL
    BEGIN
        SET @Fecha_Reserva = GETDATE();
    END

    INSERT INTO Reserva 
    (
        Fecha_Reserva,
        Titular_Reserva,
        ID_Habitacion,
        Fecha_Reserva_Inicio,
        Fecha_Reserva_Fin,
        Fecha_CheckIn,
        Fecha_CheckOut
    )
    VALUES 
    (
        @Fecha_Reserva,
        @Titular_Reserva,
        @ID_Habitacion,
        @Fecha_Reserva_Inicio,
        @Fecha_Reserva_Fin,
        @Fecha_CheckIn,
        @Fecha_CheckOut
    );

END
GO

CREATE PROCEDURE SP_Insert_Producto
    @Nombre_Producto VARCHAR(100),
    @Precio_Unidad_Producto DECIMAL(10,2),
    @Stock_Producto INT,
    @Stock_Alerta INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Nombre_Producto IS NULL OR @Nombre_Producto = ''
    BEGIN
        RAISERROR ('Error: El nombre del producto no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF @Precio_Unidad_Producto IS NULL
    BEGIN
        RAISERROR ('Error: El precio del producto no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF @Stock_Producto IS NULL
    BEGIN
        RAISERROR ('Error: El stock del producto no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF @Precio_Unidad_Producto < 0
    BEGIN
        RAISERROR ('Error: El precio del producto no puede ser negativo.', 16, 1);
        RETURN;
    END

    IF @Stock_Producto < 0
    BEGIN
        RAISERROR ('Error: El stock del producto no puede ser negativo.', 16, 1);
        RETURN;
    END

    IF @Stock_Alerta IS NULL
    BEGIN
        SET @Stock_Alerta = 5;
    END

    IF @Stock_Alerta < 0
    BEGIN
        RAISERROR ('Error: El stock de alerta no puede ser negativo.', 16, 1);
        RETURN;
    END

    INSERT INTO Producto (
        Nombre_Producto,
        Precio_Unidad_Producto,
        Stock_Alerta,
        Stock_Producto
    )
    VALUES (
        @Nombre_Producto,
        @Precio_Unidad_Producto,
        @Stock_Alerta,
        @Stock_Producto
    );

END
GO

CREATE PROCEDURE SP_Insert_Proveedor
    @CUIL_CUIT_Proveedor VARCHAR(15),
    @Razon_Social_Proveedor VARCHAR(150),
    @Telefono_Proveedor VARCHAR(20),
    @Email_Proveedor VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF @CUIL_CUIT_Proveedor IS NULL OR @CUIL_CUIT_Proveedor = ''
    BEGIN
        RAISERROR ('Error: El CUIL/CUIT del proveedor no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF @Razon_Social_Proveedor IS NULL OR @Razon_Social_Proveedor = ''
    BEGIN
        RAISERROR ('Error: La razon social no puede estar vacia.', 16, 1);
        RETURN;
    END

    IF @Telefono_Proveedor IS NULL OR @Telefono_Proveedor = ''
    BEGIN
        RAISERROR ('Error: El telefono no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF @Email_Proveedor IS NULL OR @Email_Proveedor = ''
    BEGIN
        RAISERROR ('Error: El email no puede estar vacio.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Proveedor WHERE CUIL_CUIT_Proveedor = @CUIL_CUIT_Proveedor)
    BEGIN
        RAISERROR ('Error: El CUIL/CUIT ingresado ya existe.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Proveedor WHERE Email_Proveedor = @Email_Proveedor)
    BEGIN
        RAISERROR ('Error: El email ingresado ya esta registrado.', 16, 1);
        RETURN;
    END

    IF NOT (
        @Email_Proveedor LIKE '%@%._%'
        AND CHARINDEX(' ', @Email_Proveedor) = 0
        AND LEN(@Email_Proveedor) BETWEEN 5 AND 100
    )
    BEGIN
        RAISERROR ('Error: El formato del email no es valido.', 16, 1);
        RETURN;
    END

    INSERT INTO Proveedor (
        CUIL_CUIT_Proveedor,
        Razon_Social_Proveedor,
        Telefono_Proveedor,
        Email_Proveedor
    )
    VALUES (
        @CUIL_CUIT_Proveedor,
        @Razon_Social_Proveedor,
        @Telefono_Proveedor,
        @Email_Proveedor
    );

END
GO

CREATE PROCEDURE SP_Insert_Habitacion

    @ID_Nro_Habitacion int,
    @Estado_Habitacion bit,
    @Tipo_Habitacion int

AS
BEGIN 
-- Verificar que la habitacion exista
        IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE ID_Tipo_Habitacion = @Tipo_Habitacion)
        BEGIN
            RAISERROR('El tipo de habitacion especificado no existe.', 16, 1);
            RETURN;
        END

    INSERT INTO Habitacion (ID_Nro_Habitacion, Estado_Habitacion, Tipo_Habitacion)
    VALUES (@ID_Nro_Habitacion, @Estado_Habitacion, @Tipo_Habitacion);
END;
GO

CREATE PROCEDURE SP_Insert_Personal
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
    
    -- Verificar si el email existe en Huesped
    SELECT @EmailCount = COUNT(*) 
    FROM Huesped 
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
        RAISERROR('El email ya existe en la tabla Huesped.', 16, 1);
    END;
END;
GO

CREATE PROCEDURE SP_Insert_MetodoPago
    @Nombre_MetodoPago VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Normalizo basico (opcional pero util)
        SET @Nombre_MetodoPago = LTRIM(RTRIM(@Nombre_MetodoPago));

        IF @Nombre_MetodoPago = ''
        BEGIN
            RAISERROR('El nombre del metodo de pago no puede ser vacio.', 16, 1);
            RETURN;
        END

        INSERT INTO MetodoPago (Nombre_MetodoPago)
        VALUES (@Nombre_MetodoPago);

    END TRY
    BEGIN CATCH
        -- Reenvío el error (incluye violacion de UNIQUE si hay duplicado)
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END
GO

CREATE PROCEDURE SP_Insert_TipoHabitacion
    @Nombre_Tipo_Habitacion VARCHAR(50),
    @Precio_Habitacion DECIMAL(10,2),
    @Capacidad_Habitacion INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Insertar el tipo de habitacion
    INSERT INTO TipoHabitacion (
        Nombre_Tipo_Habitacion,
        Precio_Habitacion,
        Capacidad_Habitacion
    )
    VALUES (
        @Nombre_Tipo_Habitacion,
        @Precio_Habitacion,
        @Capacidad_Habitacion
    );
END;
GO

CREATE PROCEDURE SP_Insert_Huesped
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

        -- Verificar categorÃ­a vÃ¡lida
        IF @ID_Categoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Categoria WHERE ID_Categoria = @ID_Categoria)
        BEGIN
            RAISERROR('La categoria especificada no existe.', 16, 1);
            RETURN;
        END

        INSERT INTO Huesped (
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
