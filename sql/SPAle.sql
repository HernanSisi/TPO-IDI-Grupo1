--Insert y update habitacion 

CREATE PROCEDURE SP_Insert_Habitacion
    @ID_Nro_Habitacion int,
    @Estado_Habitacion bit,
    @Tipo_Habitacion int

AS
BEGIN 
-- Verificar que la habitacion exista
        IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE Tipo_Habitacion = @Tipo_Habitacion)
        BEGIN
            RAISERROR('El tipo de habitacion especificado no existe.', 16, 1);
            RETURN;
        END

    INSERT INTO Habitacion (ID_Nro_Habitacion, Estado_Habitacion, Tipo_Habitacion)
    VALUES (@ID_Nro_Habitacion, @Estado_Habitacion, @Tipo_Habitacion);
END;
GO

EXEC SP_Insert_Habitacion 1, 1, 1

CREATE PROCEDURE SP_Update_Habitacion
    @ID_Nro_Habitacion int,
    @Estado_Habitacion bit,
    @Tipo_Habitacion int
AS
BEGIN
        IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE Tipo_Habitacion = @Tipo_Habitacion)
        BEGIN
            RAISERROR('El tipo de habitacion especificado no existe.', 16, 1);
            RETURN;
        END
    UPDATE Habitacion 
    SET
        Estado_Habitacion = COALESCE(@Estado_Habitacion, Estado_Habitacion),
        Tipo_Habitacion = COALESCE(@Tipo_Habitacion, Tipo_Habitacion)
    WHERE ID_Nro_Habitacion = @ID_Nro_Habitacion;
END;

EXEC SP_Update_Habitacion 
    @ID_Nro_Habitacion = 1,
    @Tipo_Habitacion = 2,
    @Estado_Habitacion = 0;