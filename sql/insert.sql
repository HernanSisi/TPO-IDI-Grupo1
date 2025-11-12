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

-- El resto de los datos se insertan mediante procedimientos almacenados en sql/exec.sql.
