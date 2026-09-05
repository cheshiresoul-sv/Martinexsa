SELECT TOP(5)
		a.id_articulo
		, a.descripcion
		,sum(pd.cantidad) as total_unidad
		,AVG(pd.precio_unitario * pd.cantidad) as Promedio_venta
		,STDEV(pd.precio_unitario * pd.cantidad) as derivacion_venta
		,Max(p.fecha_pedido) as ultima_fecha
FROM tst.vta_pedido_detalle pd
	left join tst.vta_pedido p
		on pd.id_detalle = p.id_orden
	join tst.inv_articulo a
		on pd.id_articulo = a.id_articulo
group by
	a.id_articulo , a.descripcion
order by total_unidad desc

select	pd.id_detalle
		,p.id_orden
		,pd.id_articulo
from	tst.vta_pedido_detalle pd
	left join tst.vta_pedido p
		on pd.id_detalle = p.id_orden
where id_articulo = 715
--group by pd.id_articulo
--order by suma desc 


SELECT A.id_orden
	,A.fecha_pedido
	,A.estado
	,A.numero_cuenta
	,A.sub_total
	,A.impuestos
	,A.flete
	,A.total_neto
	--b.nombre
	--,b.base_envio
FROM tst.vta_pedido AS A
--JOIN gral_metodo_envio AS B ON A.id_metodo_envio = B.id_metodo_envio
WHERE A.total_neto > 1000
	or A.total_neto < 500
ORDER BY A.fecha_pedido DESC

--sp_help 'tst.vta_pedido'

select top(5) * from [tst].[vta_pedido_detalle]
select top(5) * from [tst].[vta_pedido]

