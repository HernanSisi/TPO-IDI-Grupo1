-- Eliminaciones controladas; se apoyan en los datos existentes y en los cambios de exec_Update.sql

-- Quita la relación del huésped 7 en la reserva 7
EXEC SP_Delete_Reserva_Huesped
    @ID_Reserva = 7,
    @ID_Huesped = 7;

-- Elimina el vínculo de cobro y gasto de IDs 10
EXEC SP_Delete_Cobro_Gasto
    @ID_Cobro = 10,
    @ID_Gasto = 10;

-- Borra el rol 10 (debe estar libre tras ejecutar exec_Update.sql)
EXEC SP_Delete_Rol
    @ID_Rol = 10;

-- Borra el origen "Transporte" (ID 10, sin uso en los gastos demo)
EXEC SP_Delete_Origen
    @ID_Origen = 10;

-- Borra la categoría "Platinum" (ID 10, no asignada a huéspedes demo)
EXEC SP_Delete_Categoria
    @ID_Categoria = 10;
