CREATE TABLE Categoria(
    ID_Categoria INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Categoria VARCHAR(75) NOT NULL,
    Descuento_Categoria INT NOT NULL 
        CONSTRAINT chk_DescuentoValido CHECK (Descuento_Categoria BETWEEN 0 AND 100)
        DEFAULT 0
);

CREATE TABLE Rol(
ID_Rol INT IDENTITY(1,1) PRIMARY KEY,
Nombre_Rol VARCHAR(50) NOT NULL UNIQUE,
Descripcion_Rol VARCHAR(200) NOT NULL
)


CREATE TABLE Origen(
    ID_Origen INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Origen VARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE HUESPED (
    CUIL_Huesped VARCHAR(15) PRIMARY KEY,
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

CREATE TABLE Habitacion(
    ID_Nro_Habitacion INT PRIMARY KEY,
    Estado_Habitacion BIT NOT NULL DEFAULT 1,
    Tipo_Habitacion VARCHAR(50) NOT NULL,
    Precio_Habitacion DECIMAL(10,2) NOT NULL CHECK (Precio_Habitacion >= 0),
    Capacidad_Habitacion INT NOT NULL CHECK (Capacidad_Habitacion > 0)
)



CREATE TABLE MetodoPago(
    ID_MetodoPago INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_MetodoPago VARCHAR(50) NOT NULL,
)

CREATE TABLE Cobro(
    ID_Cobro INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Cobro DATETIME NOT NULL DEFAULT GETDATE(),
    Metodo_Cobro INT FOREIGN KEY REFERENCES MetodoPago(ID_MetodoPago)
)

CREATE TABLE Personal(
    CUIL_Personal VARCHAR(15) PRIMARY KEY,
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

CREATE TABLE Reserva(
    ID_Reserva INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Reserva DATETIME NOT NULL DEFAULT GETDATE(),
    Titular_Reserva VARCHAR(15) NOT NULL CONSTRAINT FK_Reserva_Huesped FOREIGN KEY REFERENCES HUESPED(CUIL_Huesped),
    ID_Habitacion INT NOT NULL CONSTRAINT FK_Reserva_Habitacion FOREIGN KEY REFERENCES Habitacion(ID_Nro_Habitacion),
    Fecha_CheckIn DATETIME NOT NULL,
    Fecha_CheckOut DATETIME NOT NULL,
    CONSTRAINT chk_Fecha_CheckOut CHECK (Fecha_CheckOut > Fecha_CheckIn)
);

CREATE TABLE Reserva_Huesped(
    ID_Reserva INT NOT NULL CONSTRAINT FK_ReservaHuesped_Reserva FOREIGN KEY REFERENCES Reserva(ID_Reserva),
    CUIL_Huesped VARCHAR(15) NOT NULL CONSTRAINT FK_ReservaHuesped_Huesped FOREIGN KEY REFERENCES HUESPED(CUIL_Huesped),
    PRIMARY KEY (ID_Reserva, CUIL_Huesped)
);

CREATE TABLE Proovedor(
    CUIL_CUIT_Proovedor VARCHAR(15) PRIMARY KEY,
    Nombre_Proovedor VARCHAR(100) NOT NULL,
    Telefono_Proovedor VARCHAR(20) NOT NULL,
    Razon_Social_Proovedor VARCHAR(150) NOT NULL,
    Email_Proovedor VARCHAR(100) NOT NULL UNIQUE
        CONSTRAINT chk_Email_Formato_Proovedor
        CHECK (
            Email_Proovedor LIKE '%@%._%'
            AND CHARINDEX(' ', Email_Proovedor) = 0
            AND LEN(Email_Proovedor) BETWEEN 5 AND 100)
);   

CREATE TABLE Producto(
    ID_Producto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Producto VARCHAR(100) NOT NULL,
    Precio_Unidad_Producto DECIMAL(10,2) NOT NULL CHECK (Precio_Unidad_Producto >= 0),
    Stock_Alerta INT NOT NULL DEFAULT 5 CHECK (Stock_Alerta >= 0),
    Stock_Producto INT NOT NULL CHECK (Stock_Producto >= 0)
);

CREATE TABLE Pedido(
    ID_Pedido INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Pedido DATETIME NOT NULL DEFAULT GETDATE(),
    CUIL_CUIT_Proovedor VARCHAR(15) NOT NULL CONSTRAINT FK_Pedido_Proovedor FOREIGN KEY REFERENCES Proovedor(CUIL_CUIT_Proovedor)
);

CREATE TABLE Pedido_Producto(
    ID_Pedido INT NOT NULL CONSTRAINT FK_PedidoProducto_Pedido FOREIGN KEY REFERENCES Pedido(ID_Pedido),
    ID_Producto INT NOT NULL CONSTRAINT FK_PedidoProducto_Producto FOREIGN KEY REFERENCES Producto(ID_Producto),
    Cantidad_Producto INT NOT NULL CHECK (Cantidad_Producto > 0),
    PRIMARY KEY (ID_Pedido, ID_Producto),
    Costo_unidad DECIMAL(10,2) NOT NULL CHECK (Costo_unidad >= 0)
);

CREATE TABLE Gasto(
    ID_Gasto INT IDENTITY(1,1) PRIMARY KEY,
    Importe DECIMAL(10,2) NOT NULL CHECK (Importe >= 0),
    Fecha_Gasto DATETIME NOT NULL DEFAULT GETDATE(),
    Producto_Gasto int NOT NULL CONSTRAINT FK_Gasto_Producto FOREIGN KEY REFERENCES Producto(ID_Producto),
    Cantidad_Producto INT NOT NULL CHECK (Cantidad_Producto > 0),
    ID_Personal VARCHAR(15) NOT NULL CONSTRAINT FK_Gasto_Personal FOREIGN KEY REFERENCES Personal(CUIL_Personal),
    ID_Reserva INT NOT NULL CONSTRAINT FK_Gasto_Reserva FOREIGN KEY REFERENCES Reserva(ID_Reserva),
    Origen_Gasto INT NOT NULL CONSTRAINT FK_Gasto_Origen FOREIGN KEY REFERENCES Origen(ID_Origen)
);

CREATE TABLE Cobro_Gasto(
    ID_Cobro INT NOT NULL CONSTRAINT FK_CobroGasto_Cobro FOREIGN KEY REFERENCES Cobro(ID_Cobro),
    ID_Gasto INT NOT NULL UNIQUE CONSTRAINT FK_CobroGasto_Gasto FOREIGN KEY REFERENCES Gasto(ID_Gasto),
    PRIMARY KEY (ID_Cobro, ID_Gasto)
);
