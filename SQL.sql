select id_PEDIDO,cliente, direccion, repartidor, subtotal, envio, total cobrado

 SELECT pe.id_pedido, cl.nombre, (cl.direccion_linea1 || ', ' || mun.nombre) as direccion
FROM pedido pe, cliente cl, departamento dep, municipio mun
WHERE pe.dui_cliente = cl.dui_cliente
AND cl.id_municipio = mun.id_municipio
AND mun.id_departamento = dep.id_departamento

Select * from pedido 

Select * from cliente

Select * from departamento

Select mun.nombre nombre_municipio, dep.nombre nombre_departamento
from municipio mun, departamento dep

SELECT 
  pe.id_pedido,
  cl.nombre AS cliente,
  (cl.direccion_linea1 || ', ' || mun.nombre) AS direccion,
  rep.nombre AS repartidor,
  COALESCE(dp.subtotal, 0) AS subtotal,
  pe.costo_envio AS envio,
  COALESCE(dp.subtotal, 0) + pe.costo_envio AS total_cobrado
FROM pedido pe
JOIN cliente cl ON pe.dui_cliente = cl.dui_cliente
JOIN municipio mun ON cl.id_municipio = mun.id_municipio
JOIN departamento dep ON mun.id_departamento = dep.id_departamento
LEFT JOIN repartidor rep ON pe.id_repartidor = rep.id_repartidor
LEFT JOIN (
  SELECT id_pedido, SUM(cantidad * precio_unitario_historico) AS subtotal
  FROM detalle_pedido
  GROUP BY id_pedido
) dp ON pe.id_pedido = dp.id_pedido
ORDER BY pe.id_pedido;
