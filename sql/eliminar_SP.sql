-- Elimina todos los procedimientos almacenados del proyecto

IF OBJECT_ID('SP_Insert_Gasto', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Gasto;
IF OBJECT_ID('SP_Insert_Cobro_Gasto', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Cobro_Gasto;
IF OBJECT_ID('SP_Insert_Pedido_Producto', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Pedido_Producto;
IF OBJECT_ID('SP_Insert_Pedido', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Pedido;
IF OBJECT_ID('SP_Insert_Cobro', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Cobro;
IF OBJECT_ID('SP_Insert_Reserva_Huesped', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Reserva_Huesped;
IF OBJECT_ID('SP_Insert_Reserva', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Reserva;
IF OBJECT_ID('SP_Insert_Producto', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Producto;
IF OBJECT_ID('SP_Insert_Proveedor', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Proveedor;
IF OBJECT_ID('SP_Insert_Habitacion', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Habitacion;
IF OBJECT_ID('SP_Insert_Personal', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Personal;
IF OBJECT_ID('SP_Insert_MetodoPago', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_MetodoPago;
IF OBJECT_ID('SP_Insert_TipoHabitacion', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_TipoHabitacion;
IF OBJECT_ID('SP_Insert_Huesped', 'P') IS NOT NULL DROP PROCEDURE SP_Insert_Huesped;

IF OBJECT_ID('SP_Update_Proveedor', 'P') IS NOT NULL DROP PROCEDURE SP_Update_Proveedor;
IF OBJECT_ID('SP_Update_Huesped', 'P') IS NOT NULL DROP PROCEDURE SP_Update_Huesped;
IF OBJECT_ID('SP_Update_Personal', 'P') IS NOT NULL DROP PROCEDURE SP_Update_Personal;
IF OBJECT_ID('SP_Update_MetodoPago', 'P') IS NOT NULL DROP PROCEDURE SP_Update_MetodoPago;
IF OBJECT_ID('SP_Update_Producto', 'P') IS NOT NULL DROP PROCEDURE SP_Update_Producto;
IF OBJECT_ID('SP_Update_TipoHabitacion', 'P') IS NOT NULL DROP PROCEDURE SP_Update_TipoHabitacion;
IF OBJECT_ID('SP_Update_Habitacion', 'P') IS NOT NULL DROP PROCEDURE SP_Update_Habitacion;

IF OBJECT_ID('SP_Delete_Reserva_Huesped', 'P') IS NOT NULL DROP PROCEDURE SP_Delete_Reserva_Huesped;
IF OBJECT_ID('SP_Delete_Cobro_Gasto', 'P') IS NOT NULL DROP PROCEDURE SP_Delete_Cobro_Gasto;
IF OBJECT_ID('SP_Delete_Rol', 'P') IS NOT NULL DROP PROCEDURE SP_Delete_Rol;
IF OBJECT_ID('SP_Delete_Origen', 'P') IS NOT NULL DROP PROCEDURE SP_Delete_Origen;
IF OBJECT_ID('SP_Delete_Categoria', 'P') IS NOT NULL DROP PROCEDURE SP_Delete_Categoria;

IF OBJECT_ID('SP_Read_PedidoDetalle', 'P') IS NOT NULL DROP PROCEDURE SP_Read_PedidoDetalle;
IF OBJECT_ID('SP_Read_GastoReserva', 'P') IS NOT NULL DROP PROCEDURE SP_Read_GastoReserva;
IF OBJECT_ID('SP_Read_CobroReserva', 'P') IS NOT NULL DROP PROCEDURE SP_Read_CobroReserva;
IF OBJECT_ID('SP_Read_PedidoResumen', 'P') IS NOT NULL DROP PROCEDURE SP_Read_PedidoResumen;
IF OBJECT_ID('SP_Read_OrigenLista', 'P') IS NOT NULL DROP PROCEDURE SP_Read_OrigenLista;
IF OBJECT_ID('SP_Read_RolDetalle', 'P') IS NOT NULL DROP PROCEDURE SP_Read_RolDetalle;
IF OBJECT_ID('SP_Read_CategoriaDescuento', 'P') IS NOT NULL DROP PROCEDURE SP_Read_CategoriaDescuento;
IF OBJECT_ID('SP_Read_ReservaDetalleCompleto', 'P') IS NOT NULL DROP PROCEDURE SP_Read_ReservaDetalleCompleto;
