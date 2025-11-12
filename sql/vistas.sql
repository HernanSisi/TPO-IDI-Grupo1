-------------------------- VISTAS -------------------------
-- Vista de Productos más demandados (top por cantidad total consumida) — agregado general
CREATE VIEW vw_ProductosMasDemandados AS
SELECT
    pr.ID_Producto,
    pr.Nombre_Producto,
    SUM(g.Cantidad_Producto) AS Total_Consumido
FROM Gasto g
INNER JOIN Producto pr ON pr.ID_Producto = g.Producto_Gasto
GROUP BY pr.ID_Producto, pr.Nombre_Producto
ORDER BY SUM(g.Cantidad_Producto) DESC;
GO

-- Vista de Consumo mensual de productos (cantidad) — útil para ver tendencia de consumo
CREATE VIEW vw_ConsumoMensualProducto AS
SELECT
    PR.ID_Producto,
    PR.Nombre_Producto,
    YEAR(G.Fecha_Gasto) AS Anio,
    MONTH(G.Fecha_Gasto) AS Mes,
    SUM(G.Cantidad_Producto) AS Cantidad_Total
FROM Gasto G
INNER JOIN Producto PR ON PR.ID_Producto = G.Producto_Gasto
GROUP BY PR.ID_Producto, PR.Nombre_Producto, YEAR(G.Fecha_Gasto), MONTH(G.Fecha_Gasto);
GO