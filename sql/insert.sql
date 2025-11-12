-- INSERCION DE DATOS
-- Tabla: Categoria
INSERT INTO Categoria (Nombre_Categoria, Descuento_Categoria) VALUES
('Estandar', 0),
('Jubilado', 15),
('Bonificado', 20),
('VIP', 10),
('Corporativo', 25),
('Promocional', 5),
('Senior', 12),
('Familiar', 8),
('Especial', 18),
('Platinum', 30);

-- Tabla: Rol
INSERT INTO Rol (Nombre_Rol, Descripcion_Rol) VALUES
('Recepcionista', 'Recepción'),
('Gerente', 'Administración'),
('Conserje', 'Limpieza'),
('Técnico', 'Mantenimiento'),
('Contador', 'Administración'),
('Chef', 'Catering'),
('Botones', 'Recepción'),
('Supervisor', 'Mantenimiento'),
('Guardia', 'Seguridad'),
('Recursos Humanos', 'Administración');

-- Tabla: Origen
INSERT INTO Origen (Nombre_Origen) VALUES
('Minibar'),
('Room Service'),
('Lavandería'),
('Restaurante'),
('Spa'),
('Estacionamiento'),
('Teléfono'),
('Internet Premium'),
('Excursiones'),
('Transporte');

-- Tabla: HUESPED
INSERT INTO HUESPED (Cedula_Huesped, Estado_Huesped, Email_Huesped, Nombre1_Huesped, Nombre2_Huesped, Apellido1_Huesped, Apellido2_Huesped, Fecha_Nacimiento_Huesped, ID_Categoria) VALUES
('20-35789456-3', 1, 'juan.perez@gmail.com', 'Juan', 'Carlos', 'Pérez', 'González', '1985-03-15', 1),
('27-42156789-5', 1, 'maria.rodriguez@hotmail.com', 'María', 'Laura', 'Rodríguez', 'Fernández', '1990-07-22', 2),
('23-38456123-9', 1, 'carlos.lopez@yahoo.com', 'Carlos', NULL, 'López', 'Martínez', '1978-11-08', 3),
('24-41789654-2', 1, 'ana.garcia@outlook.com', 'Ana', 'Sofía', 'García', 'Ramírez', '1995-02-14', 1),
('20-36541289-7', 1, 'roberto.sanchez@gmail.com', 'Roberto', 'Andrés', 'Sánchez', 'Torres', '1982-09-30', 4),
('27-43892156-1', 1, 'laura.martinez@hotmail.com', 'Laura', 'Patricia', 'Martínez', 'Díaz', '1988-05-18', 2),
('23-39784512-4', 1, 'holasoytopa@gmail.com', 'Diego', 'César', 'Topa', NULL, '1992-12-05', 5),
('24-40156987-8', 1, 'sofia.gomez@yahoo.com', 'Sofía', 'Isabel', 'Gómez', 'Moreno', '1987-08-25', 1),
('20-37894561-6', 1, 'mariposasilvestre@outlook.com', 'Celso', 'Javier', 'Díaz', 'Castro', '1980-04-12', 3),
('27-44123789-3', 1, 'valentina.romero@gmail.com', 'Valentina', 'Lucía', 'Romero', 'Herrera', '1998-01-20', 6);

-- Tabla: TipoHabitacion
INSERT INTO TipoHabitacion (Nombre_Tipo_Habitacion, Precio_Habitacion, Capacidad_Habitacion) VALUES
('Individual', 50.00, 1),
('Doble', 100.00, 2),
('Triple', 150.00, 3),
('Suite Junior', 150, 2),
('Suite Ejecutiva', 200, 3),
('Suite Presidencial', 500, 4),
('Familiar', 100, 4),
('Deluxe', 80, 2),
('Matrimonial', 100, 2),
('Cuádruple', 200, 4);

-- Tabla: Habitacion
INSERT INTO Habitacion (ID_Nro_Habitacion, Estado_Habitacion, Tipo_Habitacion) VALUES
(101, 1, 1),
(102, 1, 2),
(103, 1, 2),
(201, 1, 3),
(202, 1, 4),
(203, 0, 5),
(301, 1, 6),
(302, 1, 7),
(303, 1, 8),
(401, 1, 9);

-- Tabla: MetodoPago
INSERT INTO MetodoPago (Nombre_MetodoPago) VALUES
('Efectivo'),
('Tarjeta de Débito'),
('Tarjeta de Crédito'),
('Transferencia Bancaria'),
('MercadoPago'),
('PayPal'),
('Cheque'),
('Cripto'),
('QR'),
('Wallet Digital');

-- Tabla: Cobro
INSERT INTO Cobro (Fecha_Cobro, Metodo_Cobro) VALUES
('2024-11-01 14:30:00', 1),
('2024-11-02 09:15:00', 3),
('2024-11-03 16:45:00', 2),
('2024-11-04 11:20:00', 4),
('2024-11-05 13:50:00', 3),
('2024-11-06 10:30:00', 5),
('2024-11-07 15:00:00', 1),
('2024-11-08 12:40:00', 3),
('2024-11-09 14:10:00', 2),
('2024-11-10 09:30:00', 4);

-- Tabla: Personal
INSERT INTO Personal (Cedula_Personal, Estado_Personal, Email_Personal, Nombre1_Personal, Nombre2_Personal, Apellido1_Personal, Apellido2_Personal, Fecha_Nacimiento_Personal, Fecha_Contratacion, ID_Rol) VALUES
('20-28456789-1', 1, 'pedro.alvarez@hotelstaff.com', 'Pedro', 'Luis', 'Álvarez', 'Gómez', '1985-06-15', '2020-01-10', 1),
('27-32789456-4', 1, 'lucia.silva@hotelstaff.com', 'Lucía', 'Andrea', 'Silva', 'Morales', '1988-09-22', '2019-03-15', 2),
('23-30156789-7', 1, 'miguel.torres@hotelstaff.com', 'Miguel', NULL, 'Torres', 'Vega', '1990-12-03', '2021-07-20', 3),
('24-33894561-2', 1, 'carmen.ramirez@hotelstaff.com', 'Carmen', 'Rosa', 'Ramírez', 'Ortiz', '1986-04-18', '2018-11-05', 4),
('20-29741852-5', 1, 'jorge.castro@hotelstaff.com', 'Jorge', 'Alberto', 'Castro', 'Reyes', '1983-08-30', '2020-05-12', 5),
('27-34567891-8', 1, 'patricia.mendez@hotelstaff.com', 'Patricia', 'Elena', 'Méndez', 'Flores', '1991-02-14', '2021-09-08', 6),
('23-31478963-3', 1, 'fernando.herrera@hotelstaff.com', 'Fernando', 'José', 'Herrera', 'Luna', '1987-11-25', '2019-06-18', 7),
('24-35789123-6', 1, 'gabriela.vargas@hotelstaff.com', 'Gabriela', 'María', 'Vargas', 'Cruz', '1989-05-07', '2020-08-22', 8),
('20-30258741-9', 1, 'ricardo.molina@hotelstaff.com', 'Ricardo', 'David', 'Molina', 'Rojas', '1984-03-12', '2018-02-14', 9),
('27-36123789-4', 1, 'silvia.cortes@hotelstaff.com', 'Silvia', 'Carolina', 'Cortés', 'Navarro', '1992-10-20', '2021-04-30', 10);

-- Tabla: Reserva
INSERT INTO Reserva (Fecha_Reserva, Titular_Reserva, ID_Habitacion, Fecha_Reserva_Inicio, Fecha_Reserva_Fin, Fecha_CheckIn, Fecha_CheckOut) VALUES
('2024-10-25 10:30:00', 1, 101, '2024-11-01 15:00:00', '2024-11-05 11:00:00', '2024-11-01 15:30:00', '2024-11-05 10:45:00'),
('2024-10-26 14:20:00', 2, 102, '2024-11-03 14:00:00', '2024-11-08 12:00:00', '2024-11-03 14:20:00', '2024-11-08 11:30:00'),
('2024-10-27 09:15:00', 3, 103, '2024-11-05 16:00:00', '2024-11-10 10:00:00', '2024-11-05 16:15:00', '2024-11-10 09:50:00'),
('2024-10-28 16:45:00', 4, 201, '2024-11-07 13:00:00', '2024-11-12 11:00:00', '2024-11-07 13:30:00', '2024-11-12 05:00:00'),
('2024-10-29 11:30:00', 5, 202, '2024-11-10 15:00:00', '2024-11-15 12:00:00', '2024-11-10 15:00:00', '2024-11-15 12:00:00'),
('2024-10-30 13:00:00', 6, 301, '2024-11-12 14:00:00', '2024-11-18 11:00:00', '2024-11-12 14:00:00', '2024-11-18 11:00:00'),
('2024-10-31 15:30:00', 7, 302, '2024-11-08 16:00:00', '2024-11-13 10:00:00', '2024-11-08 16:20:00', '2024-11-13 10:00:00'),
('2024-11-01 10:00:00', 8, 303, '2024-11-09 15:00:00', '2024-11-14 12:00:00', '2024-11-09 15:10:00', '2024-11-09 15:10:10'),
('2024-11-02 12:15:00', 9, 401, '2024-11-15 14:00:00', '2024-11-20 11:00:00', '2024-11-15 14:00:00', '2024-11-20 11:00:00'),
('2024-11-03 14:45:00', 10, 102, '2024-11-20 16:00:00', '2024-11-25 10:00:00', '2024-11-20 16:00:00', '2024-11-25 10:00:00');

-- Tabla: Reserva_Huesped
INSERT INTO Reserva_Huesped (ID_Reserva, ID_Huesped) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3),
(4, 4),
(4, 5),
(5, 5),
(6, 6),
(7, 7);

-- Tabla: Proveedor
INSERT INTO Proveedor (CUIL_CUIT_Proveedor, Razon_Social_Proveedor, Telefono_Proveedor, Email_Proveedor) VALUES
('30-71234567-8', 'Labubu SA', '11-4567-8901', 'ventas@alimentoslabubu.com'),
('30-71345678-9', 'Textiles Hoteleros SRL', '11-4678-9012', 'contacto@textileshoteleros.com'),
('30-71456789-0', 'Guepardex Co', '11-4789-0123', 'pedidos@kickbuttoswki.com'),
('30-71567890-1', 'Limpieza Total SRL', '11-4890-1234', 'ventas@limpiezatotal.com'),
('30-71678901-2', 'Muebles Confort SA', '11-4901-2345', 'info@mueblesconfort.com'),
('30-71789012-3', 'Electrónica Moderna SRL', '11-4012-3456', 'ventas@electronicamoderna.com'),
('30-71890123-4', 'Decoraciones Arte SA', '11-4123-4567', 'contacto@decoracionesarte.com'),
('30-71901234-5', 'Equipamiento Pro SRL', '11-4234-5678', 'pedidos@equipamientopro.com'),
('30-72012345-6', 'Servicios Bom dia SA', '11-4345-6789', 'info@serviciosgeneralesbd.com'),
('30-72123456-7', 'Tecnología Avanzada SRL', '11-4456-7890', 'ventas@tecnologiaavanzada.com');

-- Tabla: Producto
INSERT INTO Producto (Nombre_Producto, Precio_Unidad_Producto, Stock_Alerta, Stock_Producto) VALUES
('Agua Mineral 500ml', 2.00, 20, 150),
('Chocolate Dubai Premium', 40.00, 10, 80),
('Caipirinha', 20.00, 5, 45),
('Shampoo Hotel', 5.00, 15, 200),
('Toalla Grande', 10.00, 10, 120),
('Sábanas King Size', 50.00, 8, 60),
('Commodities Pack', 100.00, 20, 180),
('Café de la Selva 250g', 120.00, 5, 40),
('Galletas Surtidas', 2.00, 15, 90),
('Jabón de Tocador', 9.00, 25, 250);

-- Tabla: Pedido
INSERT INTO Pedido (Fecha_Pedido, CUIL_CUIT_Proveedor) VALUES
('2024-10-15 10:00:00', '30-71234567-8'),
('2024-10-18 14:30:00', '30-71345678-9'),
('2024-10-20 09:15:00', '30-71456789-0'),
('2024-10-22 16:45:00', '30-71567890-1'),
('2024-10-25 11:20:00', '30-71678901-2'),
('2024-10-28 13:50:00', '30-71789012-3'),
('2024-10-30 15:30:00', '30-71890123-4'),
('2024-11-01 10:10:00', '30-71901234-5'),
('2024-11-03 12:40:00', '30-72012345-6'),
('2024-11-05 14:00:00', '30-72123456-7');

-- Tabla: Pedido_Producto
INSERT INTO Pedido_Producto (ID_Pedido, ID_Producto, Cantidad_Producto, Costo_unidad) VALUES
(1, 1, 100, 120.00),
(1, 8, 20, 1000.00),
(2, 5, 50, 700.00),
(2, 6, 30, 3000.00),
(3, 3, 25, 2200.00),
(4, 4, 80, 150.00),
(5, 7, 100, 400.00),
(6, 10, 150, 100.00),
(7, 2, 40, 300.00),
(8, 9, 60, 250.00);

-- Tabla: Gasto
INSERT INTO Gasto (Importe, Fecha_Gasto, Producto_Gasto, Cantidad_Producto, ID_Personal, ID_Reserva, Origen_Gasto, Estado_Gasto) VALUES
(450.00, '2024-11-01 18:30:00', 1, 3, 1, 1, 1, 1),
(2500.00, '2024-11-02 20:15:00', 3, 1, 1, 1, 4, 1),
(700.00, '2024-11-03 19:45:00', 2, 2, 1, 2, 1, 1),
(1200.00, '2024-11-04 21:30:00', 1, 1, 1, 2, 2, 1),
(350.00, '2024-11-05 17:20:00', 4, 2, 1, 3, 3, 1),
(1500.00, '2024-11-07 20:00:00', 7, 1, 1, 4, 4, 1),
(800.00, '2024-11-08 18:15:00', 9, 3, 1, 7, 1, 1),
(2200.00, '2024-11-09 19:30:00', 1, 1, 1, 8, 5, 1),
(600.00, '2024-11-10 17:45:00', 10, 5, 1, 3, 1, 1),
(1800.00, '2024-11-02 21:00:00', 2, 1, 1, 2, 6, 1);

-- Tabla: Cobro_Gasto
INSERT INTO Cobro_Gasto (ID_Cobro, ID_Gasto) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);