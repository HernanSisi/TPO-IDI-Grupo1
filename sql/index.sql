-- Reserva
CREATE INDEX IX_Reserva_IDHabitacion ON Reserva (ID_Habitacion);

-- Gasto
CREATE INDEX IX_Gasto_IDReserva ON Gasto (ID_Reserva);

-- Cobro
CREATE INDEX IX_Cobro_MetodoCobro ON Cobro (Metodo_Cobro);
