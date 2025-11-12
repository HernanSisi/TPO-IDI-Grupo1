-- Tabla: Categoria — Define categorías de huéspedes con su nombre y descuento aplicable.
CREATE TABLE Categoria(
    ID_Categoria INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Categoria VARCHAR(75) NOT NULL,
    Descuento_Categoria INT NOT NULL 
        CONSTRAINT chk_DescuentoValido CHECK (Descuento_Categoria BETWEEN 0 AND 100)
        DEFAULT 0
);
-- Tabla: Rol — Define los roles del personal (nombre y descripción).
CREATE TABLE Rol(
	ID_Rol INT IDENTITY(1,1) PRIMARY KEY,
	Nombre_Rol VARCHAR(50) NOT NULL UNIQUE,
	Descripcion_Rol VARCHAR(200) NOT NULL
)


-- Tabla: Origen — Catálogo de orígenes para gastos/u otras referencias.
CREATE TABLE Origen(
    ID_Origen INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Origen VARCHAR(100) NOT NULL UNIQUE
)

-- Tabla: HUESPED — Registra huéspedes (CUIL, email, nombres, apellidos, fecha de nacimiento y categoría).
CREATE TABLE HUESPED (
    ID_Huesped INT PRIMARY KEY IDENTITY(1,1),
    Cedula_Huesped VARCHAR(50) NOT NULL UNIQUE,
    Estado_Huesped BIT NOT NULL DEFAULT 1,
    Email_Huesped VARCHAR(100) NOT NULL UNIQUE
        CONSTRAINT chk_Email_Formato
        CHECK (
            Email_Huesped LIKE '%@%._%'
            AND CHARINDEX(' ', Email_Huesped) = 0
            AND LEN(Email_Huesped) BETWEEN 5 AND 100
        ),
    Nombre1_Huesped VARCHAR(50) NOT NULL,
    Nombre2_Huesped VARCHAR(50),
    Apellido1_Huesped VARCHAR(50) NOT NULL,
    Apellido2_Huesped VARCHAR(50),
    Fecha_Nacimiento_Huesped DATE NOT NULL,
    ID_Categoria INT NULL,
    CONSTRAINT FK_HUESPED_Categoria
        FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria)
);

CREATE TABLE TipoHabitacion(
    ID_Tipo_Habitacion INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Tipo_Habitacion VARCHAR(50) NOT NULL UNIQUE,
    Precio_Habitacion DECIMAL(10,2) NOT NULL CHECK (Precio_Habitacion >= 0),
    Capacidad_Habitacion INT NOT NULL CHECK (Capacidad_Habitacion > 0)
)
-- Tabla: Habitacion — Define habitaciones (número, estado, tipo, precio y capacidad).
CREATE TABLE Habitacion(
    ID_Nro_Habitacion INT PRIMARY KEY,
    Estado_Habitacion BIT NOT NULL DEFAULT 1,
    Tipo_Habitacion INT FOREIGN KEY REFERENCES TipoHabitacion(ID_Tipo_Habitacion),
    
)

-- Tabla: MetodoPago — Lista de métodos de pago disponibles.
CREATE TABLE MetodoPago(
    ID_MetodoPago INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_MetodoPago VARCHAR(50)  NOT NULL UNIQUE
)

-- Tabla: Cobro — Registra cobros realizados (fecha y método de cobro).
CREATE TABLE Cobro(
    ID_Cobro INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Cobro DATETIME NOT NULL DEFAULT GETDATE(),
    Metodo_Cobro INT FOREIGN KEY REFERENCES MetodoPago(ID_MetodoPago)
)

-- Tabla: Personal — Registra al personal (CUIL, email, datos personales, fecha de contratación y rol).
CREATE TABLE Personal(
    ID_Personal INT PRIMARY KEY IDENTITY(1,1),
    Cedula_Personal VARCHAR(50) NOT NULL UNIQUE,
    Estado_Personal BIT NOT NULL DEFAULT 1,
    Email_Personal VARCHAR(100) NOT NULL UNIQUE
        CONSTRAINT chk_Email_Formato_Personal
        CHECK (
            Email_Personal LIKE '%@%._%'
            AND CHARINDEX(' ', Email_Personal) = 0
            AND LEN(Email_Personal) BETWEEN 5 AND 100
        ),
    Nombre1_Personal VARCHAR(50) NOT NULL,
    Nombre2_Personal VARCHAR(50),
    Apellido1_Personal VARCHAR(50) NOT NULL,
    Apellido2_Personal VARCHAR(50),
    Fecha_Nacimiento_Personal DATE NOT NULL,
    Fecha_Contratacion DATE NOT NULL DEFAULT GETDATE(),
    ID_Rol INT NOT NULL,
    CONSTRAINT FK_Personal_Rol
        FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol)
);

-- Tabla: Reserva — Registra reservas (titular, habitación, fechas de check-in/out y fecha de reserva).
CREATE TABLE Reserva(
    ID_Reserva INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Reserva DATETIME NOT NULL DEFAULT GETDATE(),
    Titular_Reserva INT NOT NULL CONSTRAINT FK_Reserva_Huesped FOREIGN KEY REFERENCES HUESPED(ID_Huesped),
    ID_Habitacion INT NOT NULL CONSTRAINT FK_Reserva_Habitacion FOREIGN KEY REFERENCES Habitacion(ID_Nro_Habitacion),
    Fecha_Reserva_Inicio DATETIME NOT NULL,
    Fecha_Reserva_Fin DATETIME NOT NULL,
    Fecha_CheckIn DATETIME,
    Fecha_CheckOut DATETIME,
    CONSTRAINT chk_Fecha_Reserva_Fin CHECK (Fecha_Reserva_Fin > Fecha_Reserva_Inicio),
    CONSTRAINT chk_Fecha_CheckOut CHECK (Fecha_CheckOut > Fecha_CheckIn)
);
-- Tabla: Reserva_Huesped — Relación N:N entre reservas y huéspedes (participantes en una reserva).
CREATE TABLE Reserva_Huesped(
    ID_Reserva INT NOT NULL CONSTRAINT FK_ReservaHuesped_Reserva FOREIGN KEY REFERENCES Reserva(ID_Reserva),
    ID_Huesped INT NOT NULL CONSTRAINT FK_ReservaHuesped_Huesped FOREIGN KEY REFERENCES HUESPED(ID_Huesped),
    PRIMARY KEY (ID_Reserva, ID_Huesped)
);

-- Tabla: Proovedor — Registra proveedores (CUIL/CUIT, contacto, razón social y email).
CREATE TABLE Proveedor(
    CUIL_CUIT_Proveedor VARCHAR(15) PRIMARY KEY,
	Razon_Social_Proveedor VARCHAR(150) NOT NULL, --Una razón social es el nombre legal/ de fantasía de una persona jurídica.
    Telefono_Proveedor VARCHAR(20) NOT NULL,
    Email_Proveedor VARCHAR(100) NOT NULL UNIQUE
        CONSTRAINT chk_Email_Formato_Proveedor
        CHECK (
            Email_Proveedor LIKE '%@%._%'
            AND CHARINDEX(' ', Email_Proveedor) = 0
            AND LEN(Email_Proveedor) BETWEEN 5 AND 100)
);   

-- Tabla: Producto — Catálogo de productos con precio, stock y umbral de alerta.
CREATE TABLE Producto(
    ID_Producto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Producto VARCHAR(100) NOT NULL,
    Precio_Unidad_Producto DECIMAL(10,2) NOT NULL CHECK (Precio_Unidad_Producto >= 0),
    Stock_Alerta INT NOT NULL DEFAULT 5 CHECK (Stock_Alerta >= 0),
    Stock_Producto INT NOT NULL CHECK (Stock_Producto >= 0)
);

-- Tabla: Pedido — Registra pedidos a proveedores (fecha y proveedor asociado).
CREATE TABLE Pedido(
    ID_Pedido INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Pedido DATETIME NOT NULL DEFAULT GETDATE(),
    CUIL_CUIT_Proveedor VARCHAR(15) NOT NULL CONSTRAINT FK_Pedido_Proveedor FOREIGN KEY REFERENCES Proveedor(CUIL_CUIT_Proveedor)
);

-- Tabla INTERMEDIA: Pedido_Producto — Detalle de productos en cada pedido (cantidad y costo por unidad).
CREATE TABLE Pedido_Producto(
    ID_Pedido INT NOT NULL CONSTRAINT FK_PedidoProducto_Pedido FOREIGN KEY REFERENCES Pedido(ID_Pedido),
    ID_Producto INT NOT NULL CONSTRAINT FK_PedidoProducto_Producto FOREIGN KEY REFERENCES Producto(ID_Producto),
    Cantidad_Producto INT NOT NULL CHECK (Cantidad_Producto > 0),
    PRIMARY KEY (ID_Pedido, ID_Producto),
    Costo_unidad DECIMAL(10,2) NOT NULL CHECK (Costo_unidad >= 0)
);

-- Tabla: Gasto — Registra gastos asociados a reservas, personal y productos (importe, cantidad y origen).
CREATE TABLE Gasto(
    ID_Gasto INT IDENTITY(1,1) PRIMARY KEY,
    Importe DECIMAL(10,2) NOT NULL CHECK (Importe >= 0),
    Fecha_Gasto DATETIME NOT NULL DEFAULT GETDATE(),
    Producto_Gasto int CONSTRAINT FK_Gasto_Producto FOREIGN KEY REFERENCES Producto(ID_Producto),
    Cantidad_Producto INT NOT NULL CHECK (Cantidad_Producto > 0),
    ID_Personal INT NOT NULL CONSTRAINT FK_Gasto_Personal FOREIGN KEY REFERENCES Personal(ID_Personal),
    ID_Reserva INT NOT NULL CONSTRAINT FK_Gasto_Reserva FOREIGN KEY REFERENCES Reserva(ID_Reserva),
    Origen_Gasto INT NOT NULL CONSTRAINT FK_Gasto_Origen FOREIGN KEY REFERENCES Origen(ID_Origen),
    Estado_Gasto BIT NOT NULL DEFAULT 1
);

-- Tabla INTERMEDIA: Cobro_Gasto — Relaciona cobros con gastos (cada gasto puede tener un cobro asociado).
CREATE TABLE Cobro_Gasto(
    ID_Cobro INT NOT NULL CONSTRAINT FK_CobroGasto_Cobro FOREIGN KEY REFERENCES Cobro(ID_Cobro),
    ID_Gasto INT NOT NULL UNIQUE CONSTRAINT FK_CobroGasto_Gasto FOREIGN KEY REFERENCES Gasto(ID_Gasto),
    PRIMARY KEY (ID_Cobro, ID_Gasto)
);