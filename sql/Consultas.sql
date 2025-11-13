-- CONSULTA 1: Categorias y sus descuentos
SELECT 
    ID_Categoria,
    Nombre_Categoria,
    Descuento_Categoria
FROM Categoria
ORDER BY Descuento_Categoria DESC;

GO

-- CONSULTA 2: Huespedes con su categoria y descuento
SELECT
    H.ID_Huesped,
    H.Nombre1_Huesped,
    H.Apellido1_Huesped,
    H.Email_Huesped,
    C.Nombre_Categoria,
    C.Descuento_Categoria
FROM Huesped AS H
LEFT JOIN Categoria AS C
    ON H.ID_Categoria = C.ID_Categoria;

GO

-- CONSULTA 3: Personal del hotel y el rol que ocupa
SELECT
    P.ID_Personal,
    P.Nombre1_Personal,
    P.Apellido1_Personal,
    P.Email_Personal,
    R.Nombre_Rol,
    R.Descripcion_Rol
FROM Personal AS P
INNER JOIN Rol AS R
    ON P.ID_Rol = R.ID_Rol;

GO

-- CONSULTA 4: Habitaciones disponibles (por estado y sin reservas en el rango)
DECLARE @FechaInicio DATETIME = '2024-11-01';
DECLARE @FechaFin    DATETIME = '2024-11-10';

SELECT
    H.ID_Nro_Habitacion,
    T.Nombre_Tipo_Habitacion,
    T.Capacidad_Habitacion,
    T.Precio_Habitacion,
    H.Estado_Habitacion
FROM Habitacion AS H
INNER JOIN TipoHabitacion AS T
    ON H.Tipo_Habitacion = T.ID_Tipo_Habitacion
WHERE 
    H.Estado_Habitacion = 1
    AND H.ID_Nro_Habitacion NOT IN (
        SELECT R.ID_Habitacion
        FROM Reserva AS R
        WHERE 
            R.Fecha_Reserva_Inicio < @FechaFin
            AND R.Fecha_Reserva_Fin > @FechaInicio
    );

GO

-- CONSULTA 5: Reservas con nombre del titular y numero de habitacion
SELECT
    R.ID_Reserva,
    H.Nombre1_Huesped,
    H.Apellido1_Huesped,
    R.ID_Habitacion,
    R.Fecha_Reserva_Inicio,
    R.Fecha_Reserva_Fin
FROM Reserva AS R
INNER JOIN Huesped AS H
    ON R.Titular_Reserva = H.ID_Huesped;

GO

-- CONSULTA 6: Total de gastos por origen entre dos fechas
SELECT
    O.Nombre_Origen,
    SUM(G.Importe) AS Total_Gastos
FROM Gasto AS G
INNER JOIN Origen AS O
    ON G.Origen_Gasto = O.ID_Origen
WHERE G.Fecha_Gasto 
    BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY
    O.Nombre_Origen;

GO

-- CONSULTA 7: Huespedes que tienen al menos una reserva
SELECT
    H.Nombre1_Huesped,
    H.Apellido1_Huesped,
    COUNT(R.ID_Reserva) AS CantidadReservas
FROM Huesped AS H
INNER JOIN Reserva AS R
    ON H.ID_Huesped = R.Titular_Reserva
GROUP BY
    H.Nombre1_Huesped,
    H.Apellido1_Huesped
HAVING COUNT(R.ID_Reserva) >= 1;

GO

-- CONSULTA 8: Productos con stock por debajo del stock de alerta
SELECT
    ID_Producto,
    Nombre_Producto,
    Stock_Producto,
    Stock_Alerta
FROM Producto
WHERE Stock_Producto < Stock_Alerta;

GO

-- CONSULTA 9: Cantidad total pedida de cada producto a proveedores
SELECT
    PR.ID_Producto,
    PR.Nombre_Producto,
    SUM(PP.Cantidad_Producto) AS Cantidad_Total_Pedida
FROM Pedido_Producto AS PP
INNER JOIN Producto AS PR
    ON PP.ID_Producto = PR.ID_Producto
GROUP BY
    PR.ID_Producto,
    PR.Nombre_Producto;

GO

-- CONSULTA 10: Monto total de gastos asociados a cada reserva
SELECT
    R.ID_Reserva,
    H.Nombre1_Huesped,
    H.Apellido1_Huesped,
    SUM(G.Importe) AS Total_Gastos_Reserva
FROM Reserva AS R
INNER JOIN Huesped AS H
    ON R.Titular_Reserva = H.ID_Huesped
INNER JOIN Gasto AS G
    ON G.ID_Reserva = R.ID_Reserva
GROUP BY
    R.ID_Reserva,
    H.Nombre1_Huesped,
    H.Apellido1_Huesped;

GO

-- CONSULTA 11: Total cobrado y pendiente por reserva
SELECT
    R.ID_Reserva,
    H.Nombre1_Huesped AS Nombre_Titular,
    H.Apellido1_Huesped AS Apellido_Titular,

    SUM(G.Importe) AS Total_Gastos,

    SUM(
        CASE 
            WHEN CG.ID_Cobro IS NOT NULL THEN G.Importe 
            ELSE 0 
        END
    ) AS Total_Cobrado,

    SUM(G.Importe)
    - SUM(
        CASE 
            WHEN CG.ID_Cobro IS NOT NULL THEN G.Importe 
            ELSE 0 
        END
    ) AS Total_Pendiente
FROM Reserva AS R
INNER JOIN Huesped AS H
    ON R.Titular_Reserva = H.ID_Huesped
INNER JOIN Gasto AS G
    ON G.ID_Reserva = R.ID_Reserva
LEFT JOIN Cobro_Gasto AS CG
    ON CG.ID_Gasto = G.ID_Gasto  
GROUP BY
    R.ID_Reserva,
    H.Nombre1_Huesped,
    H.Apellido1_Huesped;
