-- Consultas de ejemplo para cada SP_Read*

EXEC SP_Read_PedidoDetalle @ID_Pedido = 1;

EXEC SP_Read_GastoReserva @ID_Reserva = 2;

EXEC SP_Read_CobroReserva @ID_Reserva = 2;

EXEC SP_Read_PedidoResumen @ID_Pedido = 1;

EXEC SP_Read_OrigenLista;

EXEC SP_Read_RolDetalle;

EXEC SP_Read_CategoriaDescuento;

EXEC SP_Read_ReservaDetalleCompleto @ID_Reserva = 2;
