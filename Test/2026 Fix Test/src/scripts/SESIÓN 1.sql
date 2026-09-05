use Martinexsa

SELECT	TOP (5)
        d.id_articulo
        , a.descripcion
        , SUM(d.cantidad) AS total_unidades
        , AVG(d.precio_unitario * d.cantidad) AS promedio_ventas
        , STDEV(d.precio_unitario * d.cantidad) AS desviacion_venta
        , MAX(p.fecha_pedido) AS ultima_fecha
FROM	tst.vta_pedido_detalle d
	JOIN	tst.vta_pedido p
		ON	p.id_orden = d.id_detalle
    JOIN    tst.inv_articulo a
        ON  d.id_articulo = a.id_articulo
GROUP BY
	d.id_articulo, a.descripcion
order by total_unidades DESC
