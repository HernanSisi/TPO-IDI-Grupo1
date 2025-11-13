-- INSERCION DE DATOS
-- Tabla: Categoria
INSERT INTO Categoria
    (Nombre_Categoria, Descuento_Categoria)
VALUES
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
INSERT INTO Rol
    (Nombre_Rol, Descripcion_Rol)
VALUES
    ('Recepcionista', 'Recepcion'),
    ('Gerente', 'Administracion'),
    ('Conserje', 'Limpieza'),
    ('Tecnico', 'Mantenimiento'),
    ('Contador', 'Administracion'),
    ('Chef', 'Catering'),
    ('Botones', 'Recepcion'),
    ('Supervisor', 'Mantenimiento'),
    ('Guardia', 'Seguridad'),
    ('Recursos Humanos', 'Administracion'),
    ('Administrador de Sistemas', 'TI');

-- Tabla: Origen
INSERT INTO Origen
    (Nombre_Origen)
VALUES
    ('Minibar'),
    ('Room Service'),
    ('Lavanderia'),
    ('Restaurante'),
    ('Spa'),
    ('Estacionamiento'),
    ('Telefono'),
    ('Internet Premium'),
    ('Excursiones'),
    ('Transporte'),
    ('Sistema');

-- El resto de los datos se insertan mediante procedimientos almacenados en sql/exec.sql.
