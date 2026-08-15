-- ============================================
-- EJERCICIOS: Funciones de agrupación en SQL
-- Base de datos: Sivar Express (Supabase)
-- ============================================

-- ============================================
-- COUNT()
-- ============================================

-- 1. ¿Cuántos pedidos totales se han hecho?
SELECT COUNT(*) AS total_pedidos
FROM pedido;

-- 2. ¿Cuántos pedidos ha hecho cada cliente?
SELECT dui_cliente, COUNT(*) AS cantidad_pedidos
FROM pedido
GROUP BY dui_cliente;

-- 3. ¿Cuántos productos distintos ha vendido cada repartidor?
SELECT id_repartidor, COUNT(DISTINCT id_pedido) AS pedidos_entregados
FROM pedido
GROUP BY id_repartidor;

-- 4. ¿Cuántos pedidos hay por estado (entregado, en camino, etc.)?
SELECT estado_pedido, COUNT(*) AS cantidad
FROM pedido
GROUP BY estado_pedido;


-- ============================================
-- SUM()
-- ============================================

-- 1. ¿Cuál es el total vendido en costos de envío?
SELECT SUM(costo_envio) AS total_envios
FROM pedido;

-- 2. ¿Cuánto ha gastado cada cliente en total (solo envíos)?
SELECT dui_cliente, SUM(costo_envio) AS total_gastado_envio
FROM pedido
GROUP BY dui_cliente;

-- 3. ¿Cuántas unidades se han vendido de cada producto?
SELECT id_producto, SUM(cantidad) AS unidades_vendidas
FROM detalle_pedido
GROUP BY id_producto;

-- 4. ¿Cuál es el ingreso total generado por cada producto?
SELECT id_producto, SUM(cantidad * precio_unitario_historico) AS ingreso_total
FROM detalle_pedido
GROUP BY id_producto
ORDER BY ingreso_total DESC;


-- ============================================
-- AVG()
-- ============================================

-- 1. ¿Cuál es el costo de envío promedio?
SELECT AVG(costo_envio) AS envio_promedio
FROM pedido;

-- 2. ¿Cuál es el promedio de unidades por pedido (detalle)?
SELECT AVG(cantidad) AS promedio_unidades_por_linea
FROM detalle_pedido;

-- 3. ¿Cuál es el precio promedio de los productos?
SELECT AVG(precio_actual) AS precio_promedio
FROM producto;

-- 4. ¿Cuál es el costo de envío promedio por método de pago?
SELECT metodo_pago, AVG(costo_envio) AS envio_promedio
FROM pedido
GROUP BY metodo_pago;


-- ============================================
-- MIN() y MAX()
-- ============================================

-- 1. ¿Cuáles son el costo de envío más bajo y más alto?
SELECT MIN(costo_envio) AS envio_minimo, MAX(costo_envio) AS envio_maximo
FROM pedido;

-- 2. ¿Cuál es el precio más caro y más barato entre los productos?
SELECT MIN(precio_actual) AS precio_minimo, MAX(precio_actual) AS precio_maximo
FROM producto;

-- 3. ¿Cuál fue la fecha del primer y del último pedido?
SELECT MIN(fecha_hora) AS primer_pedido, MAX(fecha_hora) AS ultimo_pedido
FROM pedido;

-- 4. Por cada repartidor, ¿cuál es el costo de envío más alto que ha manejado?
SELECT id_repartidor, MAX(costo_envio) AS envio_mas_alto
FROM pedido
GROUP BY id_repartidor;


-- ============================================
-- BONUS: HAVING (filtrar sobre resultados agrupados)
-- ============================================

-- Clientes que han hecho más de 1 pedido
SELECT dui_cliente, COUNT(*) AS cantidad_pedidos
FROM pedido
GROUP BY dui_cliente
HAVING COUNT(*) > 1;
