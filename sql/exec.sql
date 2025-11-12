-- HUESPED
EXEC SP_Insert_Huesped @Cedula_Huesped = '20-35789456-3', @Estado_Huesped = 1, @Email_Huesped = 'juan.perez@gmail.com', @Nombre1_Huesped = 'Juan', @Nombre2_Huesped = 'Carlos', @Apellido1_Huesped = 'Pérez', @Apellido2_Huesped = 'González', @Fecha_Nacimiento_Huesped = '1985-03-15', @ID_Categoria = 1;
EXEC SP_Insert_Huesped @Cedula_Huesped = '27-42156789-5', @Estado_Huesped = 1, @Email_Huesped = 'maria.rodriguez@hotmail.com', @Nombre1_Huesped = 'María', @Nombre2_Huesped = 'Laura', @Apellido1_Huesped = 'Rodríguez', @Apellido2_Huesped = 'Fernández', @Fecha_Nacimiento_Huesped = '1990-07-22', @ID_Categoria = 2;
EXEC SP_Insert_Huesped @Cedula_Huesped = '23-38456123-9', @Estado_Huesped = 1, @Email_Huesped = 'carlos.lopez@yahoo.com', @Nombre1_Huesped = 'Carlos', @Nombre2_Huesped = NULL, @Apellido1_Huesped = 'López', @Apellido2_Huesped = 'Martínez', @Fecha_Nacimiento_Huesped = '1978-11-08', @ID_Categoria = 3;
EXEC SP_Insert_Huesped @Cedula_Huesped = '24-41789654-2', @Estado_Huesped = 1, @Email_Huesped = 'ana.garcia@outlook.com', @Nombre1_Huesped = 'Ana', @Nombre2_Huesped = 'Sofía', @Apellido1_Huesped = 'García', @Apellido2_Huesped = 'Ramírez', @Fecha_Nacimiento_Huesped = '1995-02-14', @ID_Categoria = 1;
EXEC SP_Insert_Huesped @Cedula_Huesped = '20-36541289-7', @Estado_Huesped = 1, @Email_Huesped = 'roberto.sanchez@gmail.com', @Nombre1_Huesped = 'Roberto', @Nombre2_Huesped = 'Andrés', @Apellido1_Huesped = 'Sánchez', @Apellido2_Huesped = 'Torres', @Fecha_Nacimiento_Huesped = '1982-09-30', @ID_Categoria = 4;
EXEC SP_Insert_Huesped @Cedula_Huesped = '27-43892156-1', @Estado_Huesped = 1, @Email_Huesped = 'laura.martinez@hotmail.com', @Nombre1_Huesped = 'Laura', @Nombre2_Huesped = 'Patricia', @Apellido1_Huesped = 'Martínez', @Apellido2_Huesped = 'Díaz', @Fecha_Nacimiento_Huesped = '1988-05-18', @ID_Categoria = 2;
EXEC SP_Insert_Huesped @Cedula_Huesped = '23-39784512-4', @Estado_Huesped = 1, @Email_Huesped = 'dice@gmail.com', @Nombre1_Huesped = 'Diego', @Nombre2_Huesped = 'César', @Apellido1_Huesped = 'Topa', @Apellido2_Huesped = NULL, @Fecha_Nacimiento_Huesped = '1992-12-05', @ID_Categoria = 5;
EXEC SP_Insert_Huesped @Cedula_Huesped = '24-40156987-8', @Estado_Huesped = 1, @Email_Huesped = 'sofia.gomez@yahoo.com', @Nombre1_Huesped = 'Sofía', @Nombre2_Huesped = 'Isabel', @Apellido1_Huesped = 'Gómez', @Apellido2_Huesped = 'Moreno', @Fecha_Nacimiento_Huesped = '1987-08-25', @ID_Categoria = 1;
EXEC SP_Insert_Huesped @Cedula_Huesped = '20-37894561-6', @Estado_Huesped = 1, @Email_Huesped = 'mariposasilvestre@outlook.com', @Nombre1_Huesped = 'Celso', @Nombre2_Huesped = 'Javier', @Apellido1_Huesped = 'Díaz', @Apellido2_Huesped = 'Castro', @Fecha_Nacimiento_Huesped = '1980-04-12', @ID_Categoria = 3;
EXEC SP_Insert_Huesped @Cedula_Huesped = '27-44123789-3', @Estado_Huesped = 1, @Email_Huesped = 'valentina.romero@gmail.com', @Nombre1_Huesped = 'Valentina', @Nombre2_Huesped = 'Lucía', @Apellido1_Huesped = 'Romero', @Apellido2_Huesped = 'Herrera', @Fecha_Nacimiento_Huesped = '1998-01-20', @ID_Categoria = 6;

-- TipoHabitacion
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Individual', @Precio_Habitacion = 50.0, @Capacidad_Habitacion = 1;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Doble', @Precio_Habitacion = 100.0, @Capacidad_Habitacion = 2;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Triple', @Precio_Habitacion = 150.0, @Capacidad_Habitacion = 3;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Suite Junior', @Precio_Habitacion = 150, @Capacidad_Habitacion = 2;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Suite Ejecutiva', @Precio_Habitacion = 200, @Capacidad_Habitacion = 3;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Suite Presidencial', @Precio_Habitacion = 500, @Capacidad_Habitacion = 4;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Familiar', @Precio_Habitacion = 100, @Capacidad_Habitacion = 4;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Deluxe', @Precio_Habitacion = 80, @Capacidad_Habitacion = 2;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Matrimonial', @Precio_Habitacion = 100, @Capacidad_Habitacion = 2;
EXEC SP_Insert_TipoHabitacion @Nombre_Tipo_Habitacion = 'Cuádruple', @Precio_Habitacion = 200, @Capacidad_Habitacion = 4;

-- Habitacion
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 101, @Estado_Habitacion = 1, @Tipo_Habitacion = 1;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 102, @Estado_Habitacion = 1, @Tipo_Habitacion = 2;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 103, @Estado_Habitacion = 1, @Tipo_Habitacion = 2;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 201, @Estado_Habitacion = 1, @Tipo_Habitacion = 3;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 202, @Estado_Habitacion = 1, @Tipo_Habitacion = 4;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 203, @Estado_Habitacion = 0, @Tipo_Habitacion = 5;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 301, @Estado_Habitacion = 1, @Tipo_Habitacion = 6;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 302, @Estado_Habitacion = 1, @Tipo_Habitacion = 7;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 303, @Estado_Habitacion = 1, @Tipo_Habitacion = 8;
EXEC SP_Insert_Habitacion @ID_Nro_Habitacion = 401, @Estado_Habitacion = 1, @Tipo_Habitacion = 9;

-- MetodoPago
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'Efectivo';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'Tarjeta de Débito';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'Tarjeta de Crédito';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'Transferencia Bancaria';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'MercadoPago';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'PayPal';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'Cheque';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'Cripto';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'QR';
EXEC SP_Insert_MetodoPago @Nombre_MetodoPago = 'Astro';

-- Personal
EXEC SP_Insert_Personal @Cedula_Personal = '20-28456789-1', @Email_Personal = 'pedro.alvarez@hotelstaff.com', @Nombre1_Personal = 'Pedro', @Nombre2_Personal = 'Luis', @Apellido1_Personal = 'Álvarez', @Apellido2_Personal = 'Gómez', @Fecha_Nacimiento_Personal = '1985-06-15', @ID_Rol = 1;
EXEC SP_Insert_Personal @Cedula_Personal = '27-32789456-4', @Email_Personal = 'lucia.silva@hotelstaff.com', @Nombre1_Personal = 'Lucía', @Nombre2_Personal = 'Andrea', @Apellido1_Personal = 'Silva', @Apellido2_Personal = 'Morales', @Fecha_Nacimiento_Personal = '1988-09-22', @ID_Rol = 2;
EXEC SP_Insert_Personal @Cedula_Personal = '23-30156789-7', @Email_Personal = 'miguel.torres@hotelstaff.com', @Nombre1_Personal = 'Miguel', @Nombre2_Personal = NULL, @Apellido1_Personal = 'Torres', @Apellido2_Personal = 'Vega', @Fecha_Nacimiento_Personal = '1990-12-03', @ID_Rol = 3;
EXEC SP_Insert_Personal @Cedula_Personal = '24-33894561-2', @Email_Personal = 'carmen.ramirez@hotelstaff.com', @Nombre1_Personal = 'Carmen', @Nombre2_Personal = 'Rosa', @Apellido1_Personal = 'Ramírez', @Apellido2_Personal = 'Ortiz', @Fecha_Nacimiento_Personal = '1986-04-18', @ID_Rol = 4;
EXEC SP_Insert_Personal @Cedula_Personal = '20-29741852-5', @Email_Personal = 'jorge.castro@hotelstaff.com', @Nombre1_Personal = 'Jorge', @Nombre2_Personal = 'Alberto', @Apellido1_Personal = 'Castro', @Apellido2_Personal = 'Reyes', @Fecha_Nacimiento_Personal = '1983-08-30', @ID_Rol = 5;
EXEC SP_Insert_Personal @Cedula_Personal = '27-34567891-8', @Email_Personal = 'patricia.mendez@hotelstaff.com', @Nombre1_Personal = 'Patricia', @Nombre2_Personal = 'Elena', @Apellido1_Personal = 'Méndez', @Apellido2_Personal = 'Flores', @Fecha_Nacimiento_Personal = '1991-02-14', @ID_Rol = 6;
EXEC SP_Insert_Personal @Cedula_Personal = '23-31478963-3', @Email_Personal = 'fernando.herrera@hotelstaff.com', @Nombre1_Personal = 'Fernando', @Nombre2_Personal = 'José', @Apellido1_Personal = 'Herrera', @Apellido2_Personal = 'Luna', @Fecha_Nacimiento_Personal = '1987-11-25', @ID_Rol = 7;
EXEC SP_Insert_Personal @Cedula_Personal = '24-35789123-6', @Email_Personal = 'gabriela.vargas@hotelstaff.com', @Nombre1_Personal = 'Gabriela', @Nombre2_Personal = 'María', @Apellido1_Personal = 'Vargas', @Apellido2_Personal = 'Cruz', @Fecha_Nacimiento_Personal = '1989-05-07', @ID_Rol = 8;
EXEC SP_Insert_Personal @Cedula_Personal = '20-30258741-9', @Email_Personal = 'ricardo.molina@hotelstaff.com', @Nombre1_Personal = 'Ricardo', @Nombre2_Personal = 'David', @Apellido1_Personal = 'Molina', @Apellido2_Personal = 'Rojas', @Fecha_Nacimiento_Personal = '1984-03-12', @ID_Rol = 9;
EXEC SP_Insert_Personal @Cedula_Personal = '27-36123789-4', @Email_Personal = 'silvia.cortes@hotelstaff.com', @Nombre1_Personal = 'Silvia', @Nombre2_Personal = 'Carolina', @Apellido1_Personal = 'Cortés', @Apellido2_Personal = 'Navarro', @Fecha_Nacimiento_Personal = '1992-10-20', @ID_Rol = 10;

-- Proveedor
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-71234567-8', @Razon_Social_Proveedor = 'Labubu SA', @Telefono_Proveedor = '11-4567-8901', @Email_Proveedor = 'ventas@alimentoslabubu.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-71345678-9', @Razon_Social_Proveedor = 'Textiles Hoteleros SRL', @Telefono_Proveedor = '11-4678-9012', @Email_Proveedor = 'contacto@textileshoteleros.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-71456789-0', @Razon_Social_Proveedor = 'Guepardex Co', @Telefono_Proveedor = '11-4789-0123', @Email_Proveedor = 'pedidos@kickbuttoswki.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-71567890-1', @Razon_Social_Proveedor = 'Limpieza Total SRL', @Telefono_Proveedor = '11-4890-1234', @Email_Proveedor = 'ventas@limpiezatotal.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-71678901-2', @Razon_Social_Proveedor = 'Muebles Confort SA', @Telefono_Proveedor = '11-4901-2345', @Email_Proveedor = 'info@mueblesconfort.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-71789012-3', @Razon_Social_Proveedor = 'Electrónica Moderna SRL', @Telefono_Proveedor = '11-4012-3456', @Email_Proveedor = 'ventas@electronicamoderna.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-71890123-4', @Razon_Social_Proveedor = 'Decoraciones Arte SA', @Telefono_Proveedor = '11-4123-4567', @Email_Proveedor = 'contacto@decoracionesarte.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-71901234-5', @Razon_Social_Proveedor = 'Equipamiento Pro SRL', @Telefono_Proveedor = '11-4234-5678', @Email_Proveedor = 'pedidos@equipamientopro.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-72012345-6', @Razon_Social_Proveedor = 'Servicios Bom dia SA', @Telefono_Proveedor = '11-4345-6789', @Email_Proveedor = 'info@serviciosgeneralesbd.com';
EXEC SP_Insert_Proveedor @CUIL_CUIT_Proveedor = '30-72123456-7', @Razon_Social_Proveedor = 'Tecnología Avanzada SRL', @Telefono_Proveedor = '11-4456-7890', @Email_Proveedor = 'ventas@tecnologiaavanzada.com';

-- Producto
EXEC SP_Insert_Producto @Nombre_Producto = 'Agua Mineral 500ml', @Precio_Unidad_Producto = 2.0, @Stock_Producto = 150, @Stock_Alerta = 20;
EXEC SP_Insert_Producto @Nombre_Producto = 'Chocolate Dubai Premium', @Precio_Unidad_Producto = 40.0, @Stock_Producto = 80, @Stock_Alerta = 10;
EXEC SP_Insert_Producto @Nombre_Producto = 'Caipirinha', @Precio_Unidad_Producto = 20.0, @Stock_Producto = 45, @Stock_Alerta = 5;
EXEC SP_Insert_Producto @Nombre_Producto = 'Shampoo Hotel', @Precio_Unidad_Producto = 5.0, @Stock_Producto = 200, @Stock_Alerta = 15;
EXEC SP_Insert_Producto @Nombre_Producto = 'Toalla Grande', @Precio_Unidad_Producto = 10.0, @Stock_Producto = 120, @Stock_Alerta = 10;
EXEC SP_Insert_Producto @Nombre_Producto = 'Sábanas King Size', @Precio_Unidad_Producto = 50.0, @Stock_Producto = 60, @Stock_Alerta = 8;
EXEC SP_Insert_Producto @Nombre_Producto = 'Commodities Pack', @Precio_Unidad_Producto = 100.0, @Stock_Producto = 180, @Stock_Alerta = 20;
EXEC SP_Insert_Producto @Nombre_Producto = 'Café de la Selva 250g', @Precio_Unidad_Producto = 120.0, @Stock_Producto = 40, @Stock_Alerta = 5;
EXEC SP_Insert_Producto @Nombre_Producto = 'Galletas Surtidas', @Precio_Unidad_Producto = 2.0, @Stock_Producto = 90, @Stock_Alerta = 15;
EXEC SP_Insert_Producto @Nombre_Producto = 'Jabón de Tocador', @Precio_Unidad_Producto = 9.0, @Stock_Producto = 250, @Stock_Alerta = 25;

-- Pedido
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-71234567-8', @Fecha_Pedido = '2024-10-15 10:00:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-71345678-9', @Fecha_Pedido = '2024-10-18 14:30:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-71456789-0', @Fecha_Pedido = '2024-10-20 09:15:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-71567890-1', @Fecha_Pedido = '2024-10-22 16:45:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-71678901-2', @Fecha_Pedido = '2024-10-25 11:20:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-71789012-3', @Fecha_Pedido = '2024-10-28 13:50:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-71890123-4', @Fecha_Pedido = '2024-10-30 15:30:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-71901234-5', @Fecha_Pedido = '2024-11-01 10:10:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-72012345-6', @Fecha_Pedido = '2024-11-03 12:40:00';
EXEC SP_Insert_Pedido @CUIL_CUIT_Proveedor = '30-72123456-7', @Fecha_Pedido = '2024-11-05 14:00:00';

-- Pedido_Producto
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 1, @ID_Producto = 1, @Cantidad_Producto = 100, @Costo_unidad = 120.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 1, @ID_Producto = 8, @Cantidad_Producto = 20, @Costo_unidad = 1000.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 2, @ID_Producto = 5, @Cantidad_Producto = 50, @Costo_unidad = 700.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 2, @ID_Producto = 6, @Cantidad_Producto = 30, @Costo_unidad = 3000.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 3, @ID_Producto = 3, @Cantidad_Producto = 25, @Costo_unidad = 2200.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 4, @ID_Producto = 4, @Cantidad_Producto = 80, @Costo_unidad = 150.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 5, @ID_Producto = 7, @Cantidad_Producto = 100, @Costo_unidad = 400.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 6, @ID_Producto = 10, @Cantidad_Producto = 150, @Costo_unidad = 100.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 7, @ID_Producto = 2, @Cantidad_Producto = 40, @Costo_unidad = 300.0;
EXEC SP_Insert_Pedido_Producto @ID_Pedido = 8, @ID_Producto = 9, @Cantidad_Producto = 60, @Costo_unidad = 250.0;

-- Reserva
EXEC SP_Insert_Reserva @Titular_Reserva = 1, @ID_Habitacion = 101, @Fecha_Reserva_Inicio = '2024-11-01 15:00:00', @Fecha_Reserva_Fin = '2024-11-05 11:00:00', @Fecha_Reserva = '2024-10-25 10:30:00', @Fecha_CheckIn = '2024-11-01 15:30:00', @Fecha_CheckOut = '2024-11-05 10:45:00';
EXEC SP_Insert_Reserva @Titular_Reserva = 2, @ID_Habitacion = 102, @Fecha_Reserva_Inicio = '2024-11-03 14:00:00', @Fecha_Reserva_Fin = '2024-11-08 12:00:00', @Fecha_Reserva = '2024-10-26 14:20:00', @Fecha_CheckIn = '2024-11-03 14:20:00', @Fecha_CheckOut = '2024-11-08 11:30:00';
EXEC SP_Insert_Reserva @Titular_Reserva = 3, @ID_Habitacion = 103, @Fecha_Reserva_Inicio = '2024-11-05 16:00:00', @Fecha_Reserva_Fin = '2024-11-10 10:00:00', @Fecha_Reserva = '2024-10-27 09:15:00', @Fecha_CheckIn = '2024-11-05 16:15:00', @Fecha_CheckOut = '2024-11-10 09:50:00';
EXEC SP_Insert_Reserva @Titular_Reserva = 4, @ID_Habitacion = 201, @Fecha_Reserva_Inicio = '2024-11-07 13:00:00', @Fecha_Reserva_Fin = '2024-11-12 11:00:00', @Fecha_Reserva = '2024-10-28 16:45:00', @Fecha_CheckIn = '2024-11-07 13:30:00', @Fecha_CheckOut = '2024-11-12 05:00:00';
EXEC SP_Insert_Reserva @Titular_Reserva = 5, @ID_Habitacion = 202, @Fecha_Reserva_Inicio = '2024-11-10 15:00:00', @Fecha_Reserva_Fin = '2024-11-15 12:00:00', @Fecha_Reserva = '2024-10-29 11:30:00', @Fecha_CheckIn = '2024-11-10 15:00:00', @Fecha_CheckOut = '2024-11-15 12:00:00';
EXEC SP_Insert_Reserva @Titular_Reserva = 6, @ID_Habitacion = 301, @Fecha_Reserva_Inicio = '2024-11-12 14:00:00', @Fecha_Reserva_Fin = '2024-11-18 11:00:00', @Fecha_Reserva = '2024-10-30 13:00:00', @Fecha_CheckIn = '2024-11-12 14:00:00', @Fecha_CheckOut = '2024-11-18 11:00:00';
EXEC SP_Insert_Reserva @Titular_Reserva = 7, @ID_Habitacion = 302, @Fecha_Reserva_Inicio = '2024-11-08 16:00:00', @Fecha_Reserva_Fin = '2024-11-13 10:00:00', @Fecha_Reserva = '2024-10-31 15:30:00', @Fecha_CheckIn = '2024-11-08 16:20:00', @Fecha_CheckOut = '2024-11-13 10:00:00';
EXEC SP_Insert_Reserva @Titular_Reserva = 8, @ID_Habitacion = 303, @Fecha_Reserva_Inicio = '2024-11-09 15:00:00', @Fecha_Reserva_Fin = '2024-11-14 12:00:00', @Fecha_Reserva = '2024-11-01 10:00:00', @Fecha_CheckIn = '2024-11-09 15:10:00', @Fecha_CheckOut = '2024-11-09 15:10:10';
EXEC SP_Insert_Reserva @Titular_Reserva = 9, @ID_Habitacion = 401, @Fecha_Reserva_Inicio = '2024-11-15 14:00:00', @Fecha_Reserva_Fin = '2024-11-20 11:00:00', @Fecha_Reserva = '2024-11-02 12:15:00', @Fecha_CheckIn = '2024-11-15 14:00:00', @Fecha_CheckOut = '2024-11-20 11:00:00';
EXEC SP_Insert_Reserva @Titular_Reserva = 10, @ID_Habitacion = 102, @Fecha_Reserva_Inicio = '2024-11-20 16:00:00', @Fecha_Reserva_Fin = '2024-11-25 10:00:00', @Fecha_Reserva = '2024-11-03 14:45:00', @Fecha_CheckIn = '2024-11-20 16:00:00', @Fecha_CheckOut = '2024-11-25 10:00:00';

-- Reserva_Huesped
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 1, @ID_Huesped = 1;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 1, @ID_Huesped = 2;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 2, @ID_Huesped = 2;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 2, @ID_Huesped = 3;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 3, @ID_Huesped = 3;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 4, @ID_Huesped = 4;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 4, @ID_Huesped = 5;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 5, @ID_Huesped = 5;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 6, @ID_Huesped = 6;
EXEC SP_Insert_Reserva_Huesped @ID_Reserva = 7, @ID_Huesped = 7;

-- Cobro
EXEC SP_Insert_Cobro @ID_MetodoPago = 1, @Fecha_Cobro = '2024-11-01 14:30:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 3, @Fecha_Cobro = '2024-11-02 09:15:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 2, @Fecha_Cobro = '2024-11-03 16:45:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 4, @Fecha_Cobro = '2024-11-04 11:20:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 3, @Fecha_Cobro = '2024-11-05 13:50:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 5, @Fecha_Cobro = '2024-11-06 10:30:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 1, @Fecha_Cobro = '2024-11-07 15:00:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 3, @Fecha_Cobro = '2024-11-08 12:40:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 2, @Fecha_Cobro = '2024-11-09 14:10:00';
EXEC SP_Insert_Cobro @ID_MetodoPago = 4, @Fecha_Cobro = '2024-11-10 09:30:00';

-- Gasto
EXEC SP_Insert_Gasto @Importe = 450.0, @Fecha_Gasto = '2024-11-01 18:30:00', @Producto_Gasto = 1, @Cantidad_Producto = 3, @ID_Personal = 1, @ID_Reserva = 1, @Origen_Gasto = 1;
EXEC SP_Insert_Gasto @Importe = 2500.0, @Fecha_Gasto = '2024-11-02 20:15:00', @Producto_Gasto = 3, @Cantidad_Producto = 1, @ID_Personal = 1, @ID_Reserva = 1, @Origen_Gasto = 4;
EXEC SP_Insert_Gasto @Importe = 700.0, @Fecha_Gasto = '2024-11-03 19:45:00', @Producto_Gasto = 2, @Cantidad_Producto = 2, @ID_Personal = 1, @ID_Reserva = 2, @Origen_Gasto = 1;
EXEC SP_Insert_Gasto @Importe = 1200.0, @Fecha_Gasto = '2024-11-04 21:30:00', @Producto_Gasto = 1, @Cantidad_Producto = 1, @ID_Personal = 1, @ID_Reserva = 2, @Origen_Gasto = 2;
EXEC SP_Insert_Gasto @Importe = 350.0, @Fecha_Gasto = '2024-11-05 17:20:00', @Producto_Gasto = 4, @Cantidad_Producto = 2, @ID_Personal = 1, @ID_Reserva = 3, @Origen_Gasto = 3;
EXEC SP_Insert_Gasto @Importe = 1500.0, @Fecha_Gasto = '2024-11-07 20:00:00', @Producto_Gasto = 7, @Cantidad_Producto = 1, @ID_Personal = 1, @ID_Reserva = 4, @Origen_Gasto = 4;
EXEC SP_Insert_Gasto @Importe = 800.0, @Fecha_Gasto = '2024-11-08 18:15:00', @Producto_Gasto = 9, @Cantidad_Producto = 3, @ID_Personal = 1, @ID_Reserva = 7, @Origen_Gasto = 1;
EXEC SP_Insert_Gasto @Importe = 2200.0, @Fecha_Gasto = '2024-11-09 19:30:00', @Producto_Gasto = 1, @Cantidad_Producto = 1, @ID_Personal = 1, @ID_Reserva = 8, @Origen_Gasto = 5;
EXEC SP_Insert_Gasto @Importe = 600.0, @Fecha_Gasto = '2024-11-10 17:45:00', @Producto_Gasto = 10, @Cantidad_Producto = 5, @ID_Personal = 1, @ID_Reserva = 3, @Origen_Gasto = 1;
EXEC SP_Insert_Gasto @Importe = 1800.0, @Fecha_Gasto = '2024-11-02 21:00:00', @Producto_Gasto = 2, @Cantidad_Producto = 1, @ID_Personal = 1, @ID_Reserva = 2, @Origen_Gasto = 6;

-- Cobro_Gasto
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 1, @ID_Gasto = 1;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 2, @ID_Gasto = 2;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 3, @ID_Gasto = 3;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 4, @ID_Gasto = 4;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 5, @ID_Gasto = 5;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 6, @ID_Gasto = 6;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 7, @ID_Gasto = 7;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 8, @ID_Gasto = 8;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 9, @ID_Gasto = 9;
EXEC SP_Insert_Cobro_Gasto @ID_Cobro = 10, @ID_Gasto = 10;
