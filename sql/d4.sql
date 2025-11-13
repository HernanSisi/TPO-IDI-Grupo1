-- FUNCION 1: Devuelve el total cobrado entre dos fechas
CREATE FUNCTION FN_TotalCobrado
(
    @FechaInicio DATETIME,
    @FechaFin    DATETIME
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalCobrado DECIMAL(18,2);

    SELECT 
        @TotalCobrado = ISNULL(SUM(G.Importe), 0)
    FROM Cobro AS C
    JOIN Cobro_Gasto AS CG
        ON C.ID_Cobro = CG.ID_Cobro
    JOIN Gasto AS G
        ON CG.ID_Gasto = G.ID_Gasto
    WHERE 
        C.Fecha_Cobro BETWEEN @FechaInicio AND @FechaFin;

    RETURN @TotalCobrado;
END;
GO


-- FUNCION 2: Devuelve el total gastado entre dos fechas
CREATE FUNCTION FN_TotalGastado
(
    @FechaInicio DATETIME,
    @FechaFin    DATETIME
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalGastado DECIMAL(18,2);

    SELECT 
        @TotalGastado = ISNULL(SUM(PP.Cantidad_Producto * PP.Costo_unidad), 0)
    FROM Pedido AS P
    JOIN Pedido_Producto AS PP
        ON P.ID_Pedido = PP.ID_Pedido
    WHERE 
        P.Fecha_Pedido BETWEEN @FechaInicio AND @FechaFin;

    RETURN @TotalGastado;
END;
GO



-- PROCEDIMIENTO: Devuelve el dinero neto (cobrado - gastado)
CREATE PROCEDURE SP_Read_DineroNeto
    @FechaInicio DATETIME,
    @FechaFin    DATETIME
AS
BEGIN
    DECLARE @Cobrado DECIMAL(18,2);
    DECLARE @Gastado DECIMAL(18,2);
    DECLARE @Neto    DECIMAL(18,2);

    SET @Cobrado = dbo.FN_TotalCobrado(@FechaInicio, @FechaFin);
    SET @Gastado = dbo.FN_TotalGastado(@FechaInicio, @FechaFin);
    SET @Neto    = @Cobrado - @Gastado;

    SELECT 
        @Cobrado AS Total_Cobrado,
        @Gastado AS Total_Gastado,
        @Neto    AS Dinero_Neto;
END;
GO

EXEC SP_DineroNeto '2024-10-01', '2024-12-31';
