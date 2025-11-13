-- Huesped
CREATE INDEX IX_Huesped_Cedula ON Huesped (Cedula_Huesped);

-- GASTO
CREATE INDEX IX_Gasto_IDReserva ON Gasto (ID_Reserva);

-- PEDIDO
CREATE INDEX IX_Pedido_Proveedor ON Pedido (CUIL_CUIT_Proveedor);

-- RESERVA
CREATE INDEX IX_Reserva_IDHabitacion ON Reserva (ID_Habitacion);
