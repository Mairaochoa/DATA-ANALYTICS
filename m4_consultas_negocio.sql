SELECT * FROM Ventas;
--total facturado, cant de pedidos y ticket promedio
SELECT
MONTH(fecha_venta) as Mes,
SUM(cantidad * precio_unitario) as Total_facturado,
COUNT(id_venta) as cantidad_pedidos,
AVG(cantidad * precio_unitario) as ticket_promedio 
FROM Ventas
GROUP BY MONTH(fecha_venta);

-- TOP 5 productos
SELECT TOP 5
id_producto,
COUNT(cantidad) as Unidades_vendidas,
SUM(cantidad * precio_unitario) as total_generado
FROM Ventas
GROUP BY id_producto
order by total_generado DESC;

-- Clientes recurrentes con más de 1 pedido
SELECT 
id_cliente, 
COUNT(cantidad) as cantidad_pedidos,
SUM(cantidad * precio_unitario) as total_gastado
FROM Ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

--Total facturado por mes/por encima o por debajo

WITH Facturacion_mensual as (
SELECT 
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) as Total_mes
FROM Ventas
GROUP BY MONTH(fecha_venta)
)
SELECT 
mes, 
Total_mes,
CASE
WHEN Total_mes > (SELECT AVG(Total_mes) FROM Facturacion_mensual) THEN 'Por encima'
ELSE 'Por debajo'
END AS Etiqueta
FROM Facturacion_mensual;

----BLOQUE DE CIERRE---
--1 El total facturado en el mes de marzo es de 6444, con una cantidad de 10 pedidos, siendo el ticket promedio de 644.40.
--2 El producto con id_producto 1 concentra la mayor cantidad de ingresos dentro del top 5.
--3 Hubo un total de 5 clientes recurrentes que realizaron más de un pedido en el mes.
