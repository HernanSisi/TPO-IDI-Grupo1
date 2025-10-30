-- PROCEDIMIENTOS ALMACENADOS.

-- Para categoría: READ y DELETE

CREATE PROCEDURE SP_ReadCategoria
AS
BEGIN
	SELECT ID_Categoria, Nombre_Categoria, Descuento_Categoria FROM Categoria;
END;

EXEC SP_ReadCategoria;

CREATE PROCEDURE SP_DeleteCategoria
	@ID_Categoria int
AS
BEGIN
	DELETE FROM Categoria
	WHERE ID_Categoria = @ID_Categoria;
END;

EXEC SP_DeleteCategoria 1;


-- Rol: READ y DELETE

CREATE PROCEDURE SP_ReadRol
AS
BEGIN
	SELECT ID_Rol, Nombre_Rol, Descripcion_Rol FROM Rol;
END;

EXEC SP_ReadRol;

CREATE PROCEDURE SP_DeleteRol
	@ID_Rol int
AS
BEGIN
	DELETE FROM Rol
	WHERE ID_Rol = @ID_Rol;
END;

EXEC SP_DeleteRol 1;

-- Origen: READ y DELETE
CREATE PROCEDURE SP_ReadOrigen
AS
BEGIN
	SELECT ID_Origen, Nombre_Origen FROM Origen;
END;

EXEC SP_ReadOrigen;

CREATE PROCEDURE SP_DeleteOrigen
	@ID_Origen int
AS
BEGIN
	DELETE FROM Origen
	WHERE ID_Origen = @ID_Origen;
END;

EXEC SP_DeleteOrigen 1;


-- HUESPED: INSERT y UPDATE

-- COMPROBAR EN AMBOS QUE LOS EMAIL NO COINCIDAN CON UN EMAIL DE PERSONAL.
CREATE PROCEDURE SP_InsertHuesped

	@CUIL_Huesped int, 
	@Estado_Huesped bit, 
	@Email_Huesped varchar(100), 
	@Nombre1_Huesped varchar(50), 
	@Nombre2_Huesped varchar(50), 
	@Apellido1_Huesped varchar(50), 
	@Apellido2_Huesped varchar(50), 
	@Fecha_Nacimiento_Huesped date, 
	@ID_Categoria int

AS 
BEGIN 
	INSERT INTO HUESPED (CUIL_Huesped, Estado_Huesped, Email_Huesped, Nombre1_Huesped, Nombre2_Huesped, Apellido1_Huesped, Apellido2_Huesped, Fecha_Nacimiento_Huesped, ID_Categoria) 
	VALUES (@CUIL_Huesped, @Estado_Huesped, @Email_Huesped, @Nombre1_Huesped, @Nombre2_Huesped, @Apellido1_Huesped, @Apellido2_Huesped, @Fecha_Nacimiento_Huesped, @ID_Categoria);
END;

EXEC SP_InsertHuesped 047028021, null, 'nadia@gmail.com', 'Nadia', 'Zaira', 'Dowhopolyj', null, '11-10-2005', 1;

CREATE PROCEDURE SP_UpdateHuesped 

	@CUIL_Huesped int, 
	@Estado_Huesped bit, 
	@Email_Huesped varchar(100), 
	@Nombre1_Huesped varchar(50), 
	@Nombre2_Huesped varchar(50), 
	@Apellido1_Huesped varchar(50), 
	@Apellido2_Huesped varchar(50), 
	@Fecha_Nacimiento_Huesped date, 
	@ID_Categoria int
AS 
BEGIN
	UPDATE Huesped
	SET 

	CUIL_Huesped = @CUIL_Huesped, 
	Estado_Huesped = @Estado_Huesped, 
	Email_Huesped = @Email_Huesped, 
	Nombre1_Huesped = @Nombre1_Huesped, 
	Nombre2_Huesped = @Nombre2_Huesped, 
	Apellido1_Huesped = @Apellido1_Huesped, 
	Apellido2_Huesped = @Apellido2_Huesped, 
	Fecha_Nacimiento_Huesped = @Fecha_Nacimiento_Huesped, 
	ID_Categoria = @ID_Categoria

	WHERE CUIL_Huesped = @CUIL_Huesped;
END;

EXEC SP_UpdateHuesped 047028021, null, 'nadia@gmail.com', 'Nadia', 'Zaira', 'Dowhopolyj', null, '11-10-2005', 1;



