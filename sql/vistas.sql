-------------------------- VISTAS -------------------------
-- vista de Productos más demandados (top por cantidad total consumida) — agregado general
CREATE VIEW vw_ProductosMasDemandados AS
SELECT
    pr.ID_Producto,
    pr.Nombre_Producto,
    SUM(g.Cantidad_Producto) AS Total_Consumido
FROM Gasto g
INNER JOIN Producto pr ON pr.ID_Producto = g.Producto_Gasto
GROUP BY pr.ID_Producto, pr.Nombre_Producto;
GO

-- select * from vw_ProductosMasDemandados order by Total_Consumido desc
-- Vista de Consumo mensual de productos (cantidad) — útil para ver tendencia de consumo

CREATE VIEW vw_ConsumoMensualProducto AS
SELECT
    PR.ID_Producto,
    PR.Nombre_Producto,
    CONCAT(
    YEAR(G.Fecha_Gasto), '-',
    RIGHT('0' + CAST(MONTH(G.Fecha_Gasto) AS varchar(2)), 2)
    ) AS Periodo_YYYY_MM,
    SUM(G.Cantidad_Producto) AS Cantidad_Total
FROM Gasto G
INNER JOIN Producto PR ON PR.ID_Producto = G.Producto_Gasto
GROUP BY PR.ID_Producto, PR.Nombre_Producto, CONCAT( 
    YEAR(G.Fecha_Gasto), '-',
    RIGHT('0' + CAST(MONTH(G.Fecha_Gasto) AS varchar(2)), 2)
    );
GO

-- select * from vw_ConsumoMensualProducto