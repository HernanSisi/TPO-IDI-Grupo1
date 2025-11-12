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


-- SP Insertar TipoHabitacion
CREATE PROCEDURE SP_TipoHabitacion_Insert
    @Nombre_Tipo_Habitacion VARCHAR(50),
    @Precio_Habitacion DECIMAL(10,2),
    @Capacidad_Habitacion INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Insertar el tipo de habitación
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


-- Insertar habitación simple
EXEC SP_TipoHabitacion_Insert
    @Nombre_Tipo_Habitacion = 'Simple',
    @Precio_Habitacion = 5000.00,
    @Capacidad_Habitacion = 1;

-- Insertar habitación doble
EXEC SP_TipoHabitacion_Insert
    @Nombre_Tipo_Habitacion = 'Doble',
    @Precio_Habitacion = 8000.00,
    @Capacidad_Habitacion = 2;

EXEC SP_TipoHabitacion_Insert
    @Nombre_Tipo_Habitacion = 'Triple',
    @Precio_Habitacion = 12000.00,
    @Capacidad_Habitacion = 3;
-- Insertar suite
EXEC SP_TipoHabitacion_Insert
    @Nombre_Tipo_Habitacion = 'Suite Presidencial',
    @Precio_Habitacion = 25000.00,
    @Capacidad_Habitacion = 4;


--- SP Actualizar TipoHabitacion
CREATE PROCEDURE SP_TipoHabitacion_Update
    @ID_Tipo_Habitacion INT,
    @Nombre_Tipo_Habitacion VARCHAR(50) = NULL,
    @Precio_Habitacion DECIMAL(10,2) = NULL,
    @Capacidad_Habitacion INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- UPDATE manteniendo valores actuales si el parámetro es NULL
    UPDATE TipoHabitacion
    SET 
        Nombre_Tipo_Habitacion = COALESCE(@Nombre_Tipo_Habitacion, Nombre_Tipo_Habitacion),
        Precio_Habitacion = COALESCE(@Precio_Habitacion, Precio_Habitacion),
        Capacidad_Habitacion = COALESCE(@Capacidad_Habitacion, Capacidad_Habitacion)
    WHERE ID_Tipo_Habitacion = @ID_Tipo_Habitacion;
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe tipo de habitación con ese ID.', 16, 1);
    END
END;
GO

-- Cambiar solo el precio
EXEC SP_TipoHabitacion_Update
    @ID_Tipo_Habitacion = 1,
    @Precio_Habitacion = 5500.00;

-- Cambiar nombre y capacidad
EXEC SP_TipoHabitacion_Update
    @ID_Tipo_Habitacion = 1,
    @Nombre_Tipo_Habitacion = 'Simple Premium',
    @Capacidad_Habitacion = 2;

-- Cambiar todos los campos
EXEC SP_TipoHabitacion_Update
    @ID_Tipo_Habitacion = 2,
    @Nombre_Tipo_Habitacion = 'Doble Deluxe',
    @Precio_Habitacion = 9500.00,
    @Capacidad_Habitacion = 3;


--SP Eliminar Reserva_Huesped
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
-- Eliminar la relación entre la reserva 1 y el huésped 2
EXEC SP_ReservaHuesped_Delete
    @ID_Reserva = 1,
    @ID_Huesped = 2; 

-- Intentar eliminar una relación inexistente
EXEC SP_ReservaHuesped_Delete
    @ID_Reserva = 999,
    @ID_Huesped = 888;
GO

GO
-- SP Leer Pedido con detalle
CREATE PROCEDURE SP_Pedido_Read
    @ID_Pedido INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validación de existencia
    IF NOT EXISTS (SELECT 1 FROM Pedido WHERE ID_Pedido = @ID_Pedido)
    BEGIN
        RAISERROR('No existe pedido con ese ID.', 16, 1);
        RETURN;
    END

    -- Encabezado + total del pedido
    SELECT 
        p.ID_Pedido,
        p.Fecha_Pedido,
        pr.CUIL_CUIT_Proveedor,
        pr.Razon_Social_Proveedor,
        pr.Telefono_Proveedor,
        pr.Email_Proveedor,
        Total_Pedido = (
            SELECT SUM(pp.Cantidad_Producto * pp.Costo_unidad)
            FROM Pedido_Producto pp
            WHERE pp.ID_Pedido = p.ID_Pedido
        )
    FROM Pedido p
    INNER JOIN Proveedor pr ON pr.CUIL_CUIT_Proveedor = p.CUIL_CUIT_Proveedor
    WHERE p.ID_Pedido = @ID_Pedido;

    -- Detalle del pedido (líneas)
    SELECT 
        pp.ID_Producto,
        prod.Nombre_Producto,
        pp.Cantidad_Producto,
        pp.Costo_unidad,
        Subtotal = pp.Cantidad_Producto * pp.Costo_unidad
    FROM Pedido_Producto pp
    INNER JOIN Producto prod ON prod.ID_Producto = pp.ID_Producto
    WHERE pp.ID_Pedido = @ID_Pedido
    ORDER BY prod.Nombre_Producto;
END
GO
EXEC SP_Pedido_Read @ID_Pedido = 2;



-- SP Leer Gasto por Reserva
GO
CREATE PROCEDURE SP_Gasto_ReadPorReserva
    @ID_Reserva INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE ID_Reserva = @ID_Reserva)
    BEGIN
        RAISERROR('No existe reserva con ese ID.', 16, 1);
        RETURN;
    END

    SELECT
        r.ID_Reserva,
        r.Fecha_Reserva,
        Total_Gastos         = COUNT(g.ID_Gasto),
        Total_Activos        = SUM(CASE WHEN g.Estado_Gasto = 1 THEN 1 ELSE 0 END),
        Total_Anulados       = SUM(CASE WHEN g.Estado_Gasto = 0 THEN 1 ELSE 0 END),
        Monto_Total_Activos  = SUM(CASE WHEN g.Estado_Gasto = 1 THEN g.Importe ELSE 0 END),
        Monto_Total_Anulados = SUM(CASE WHEN g.Estado_Gasto = 0 THEN g.Importe ELSE 0 END)
    FROM Reserva r
    LEFT JOIN Gasto g
        ON g.ID_Reserva = r.ID_Reserva
    WHERE r.ID_Reserva = @ID_Reserva
    GROUP BY r.ID_Reserva, r.Fecha_Reserva;

END
GO


EXEC SP_Gasto_ReadPorReserva @ID_Reserva = 4;

GO



-- SP Leer Cobro por Reserva
CREATE PROCEDURE SP_Cobro_ReadPorReserva
    @ID_Reserva INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que la reserva exista
    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE ID_Reserva = @ID_Reserva)
    BEGIN
        RAISERROR('No existe reserva con ese ID.', 16, 1);
        RETURN;
    END

    -- Un solo SELECT con todo el detalle de cobros
    SELECT
        r.ID_Reserva,
        c.ID_Cobro,
        c.Fecha_Cobro,
        mp.Nombre_MetodoPago,
        g.ID_Gasto,
        g.Fecha_Gasto,
        g.Importe,
        g.Cantidad_Producto,
        p.Nombre_Producto,
        o.Nombre_Origen,
        per.Nombre1_Personal + ' ' + per.Apellido1_Personal AS Personal_Responsable
    FROM Reserva r
    INNER JOIN Gasto g          ON g.ID_Reserva = r.ID_Reserva
    INNER JOIN Cobro_Gasto cg   ON cg.ID_Gasto = g.ID_Gasto
    INNER JOIN Cobro c          ON c.ID_Cobro = cg.ID_Cobro
    INNER JOIN MetodoPago mp    ON mp.ID_MetodoPago = c.Metodo_Cobro
    INNER JOIN Producto p       ON p.ID_Producto = g.Producto_Gasto
    INNER JOIN Origen o         ON o.ID_Origen = g.Origen_Gasto
    INNER JOIN Personal per     ON per.ID_Personal = g.ID_Personal
    WHERE r.ID_Reserva = @ID_Reserva
    ORDER BY c.Fecha_Cobro DESC, g.Fecha_Gasto DESC;
END
GO
EXEC SP_Cobro_ReadPorReserva @ID_Reserva = 4;

GO
-- SP Leer Pedido sin detalle
CREATE PROCEDURE SP_PedidoSDetalle_Read
    @ID_Pedido INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ID_Pedido,
        p.Fecha_Pedido,
        p.CUIL_CUIT_Proveedor
    FROM Pedido p
    WHERE p.ID_Pedido = @ID_Pedido;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No existe pedido con ese ID.', 16, 1);
    END
END
GO


EXEC SP_PedidoSDetalle_Read @ID_Pedido = 2;


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

EXEC SP_CobroGasto_Delete 
    @ID_Cobro = 1, 
    @ID_Gasto = 5;
