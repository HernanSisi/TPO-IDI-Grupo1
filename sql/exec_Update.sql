-- Actualizaciones de ejemplo ligadas a los datos sembrados por insert.sql y exec_Insert.sql

-- Ajusta correo y estado del huesped con ID 1
EXEC SP_Update_Huesped
    @ID_Huesped = 1,
    @Email_Huesped = 'juan.perezvip@gmail.com',
    @Estado_Huesped = 1;

-- Actualiza precio/capacidad del tipo de habitacion Individual (ID 1)
EXEC SP_Update_TipoHabitacion
    @ID_Tipo_Habitacion = 1,
    @Precio_Habitacion = 55,
    @Capacidad_Habitacion = 1;

-- Habilita la habitacion 203 y la reasigna al tipo 5
EXEC SP_Update_Habitacion
    @ID_Nro_Habitacion = 203,
    @Estado_Habitacion = 1,
    @Tipo_Habitacion = 5;

-- Renombra el metodo de pago "Efectivo" (ID 1)
EXEC SP_Update_MetodoPago
    @ID_MetodoPago = 1,
    @Nombre_MetodoPago = 'Efectivo Caja';

-- Ajusta valores del producto Agua Mineral (ID 1)
EXEC SP_Update_Producto
    @ID_Producto = 1,
    @Precio_Unidad_Producto = 2.50,
    @Stock_Alerta = 25;

-- Actualiza datos de contacto del proveedor Labubu SA
EXEC SP_Update_Proveedor
    @CUIL_CUIT_Proveedor = '30-71234567-8',
    @Telefono_Proveedor = '11-4567-0000',
    @Email_Proveedor = 'soporte@alimentoslabubu.com';

-- Cambia correo y rol del personal con ID 10 para liberar el Rol 10
EXEC SP_Update_Personal
    @ID_Personal = 10,
    @Email_Personal = 'silvia.cortes@hotelmacacookie.com',
    @ID_Rol = 9;

select * from Personal