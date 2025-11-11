-- /Insert Categorias/
INSERT INTO Categoria ([Nombre_Categoria], [Descuento_Categoria]) VALUES 
('Estandar', 0),
('Jubilado', 20),
('Bonificado', 15),
('VIP', 30),
('Corporativo', 20),
('Promocional', 10);

-- /Insert Huespedes/
INSERT INTO HUESPED ([Cedula_Huesped], [Estado_Huesped], [Email_Huesped], [Nombre1_Huesped], [Nombre2_Huesped], [Apellido1_Huesped], [Apellido2_Huesped], [Fecha_Nacimiento_Huesped], [ID_Categoria]) VALUES
(27857603918, 1, 'alejandraortiz@gmail.com', 'Alejandra', NULL, 'Ortiz', NULL, '2001-05-27', 1), 
(25897404928, 1, 'pepegarciaz@yahoo.com.ar', 'José', 'Alejandro', 'García', NULL, '1998-05-07', 3), 
(20473896154, 1, 'damiancito@yahoo.es', 'Damián', NULL, 'Rodriguez', 'Trujillo', '1984-12-10', 3),
(27488680715, 1, 'lucialopez@gmail.com', 'Lucía', NULL, 'Lopez', 'Giorello', '2004-06-27', 1), 
(27569481045, 1, 'myriamrosa@yahoo.com.ar', 'Myriam', 'Rosa', 'Aguilar', NULL, '1990-02-09', 5), 
(20202020202, 1, 'danielfeisho@yahoo.es', 'Daniel', 'Joseph', 'Feisho', NULL, '1980-06-10', 4),
(27849562123, 1, 'noraesnora@gmail.com', 'Nora', 'Andrea', 'Reinoso', NULL, '1971-02-25', 6),
(24747838329, 1, 'holasoytopa@gmail.com.ar', 'Diego', 'César', 'Topa', NULL, '1975-10-11', 2),
(27272727272, 1, 'mariposasilvestre@gmail.com', 'Celso', NULL, 'Barragan', NULL, '1964-02-25', 2),
(20895674192, 1, 'lionelmessi@gmail.com', 'Lionel', 'Andrés', 'Messi', 'Cuccittini', '1987-06-24', 6);

-- /Insert Rol Personal/
INSERT INTO Rol ([Nombre_Rol], [Descripcion_Rol]) VALUES 
('Conserje','Limpieza'),
('Amadellaves','Limpieza'),
('Manitas','Recepcion'),
('Recepcionista','Recepcion'),
('Mozo','Catering'),
('Cocinero','Catering'),
('Bartender','Catering'),
('Guardia','Seguridad'),
('Tecnico','Mantenimiento'),
('Jardinero','Mantenimiento');

-- /Insert Personal/
INSERT INTO Personal([Cedula_Personal], [Estado_Personal], [Email_Personal], [Nombre1_Personal], [Nombre2_Personal], [Apellido1_Personal], [Apellido2_Personal], [Fecha_Nacimiento_Personal], [Fecha_Contratacion], [ID_Rol]) VALUES
(20345678901, 1, 'juanperez@hotmail.com', 'Juan', 'Carlos', 'Pérez', 'Gómez', '1988-03-15', '2015-06-01',1),
(27234567892, 1, 'marialopez@gmail.com', 'María', 'Fernanda', 'López', 'Martínez', '1990-07-22', '2017-09-15',2),
(23198765433, 1, 'lucasrodriguez@yahoo.com', 'Lucas', 'Andrés', 'Rodríguez', 'Soto', '1985-11-02', '2012-01-10',3),
(24321098764, 1, 'sofiagarcia@gmail.com', 'Sofía', 'Belén', 'García', 'Torres', '1992-05-19', '2019-03-25',4),
(27456789015, 1, 'martingonzalez@gmail.com', 'Martín', 'Eduardo', 'González', 'Ruiz', '1989-09-11', '2016-04-12',5),
(23567890126, 1, 'carladiaz@gmail.com', 'Carla', 'Julieta', 'Díaz', 'Moreno', '1994-12-30', '2020-01-08',6),
(20678901237, 1, 'nicolasfernandez@yahoo.es', 'Nicolás', 'Iván', 'Fernández', 'Luna', '1991-01-17', '2018-08-14',7),
(27789012348, 1, 'valentinasosa@gmail.com', 'Valentina', 'María', 'Sosa', 'Paz', '1993-04-09', '2021-11-03',8),
(23890123459, 1, 'diegosilva@gmail.com', 'Diego', 'Alejandro', 'Silva', 'Ortiz', '1987-10-26', '2014-02-20',9),
(27901234560, 1, 'camilamendez@gmail.com', 'Camila', 'Rocío', 'Méndez', 'Acosta', '1996-06-12', '2022-07-01',10),
(27488680715, 1, 'lucia.lopez@yahoo.com', 'Lucía', NULL, 'Lopez', 'Giorello', '2004-06-27', '2024-07-02',8);
