
SELECT A.id_orden
	,A.fecha_pedido
	,CASE 
		WHEN A.estado LIKE '%1%'
			THEN 'Iniciando'
		WHEN A.estado LIKE '%2%'
			THEN 'Procesando'
		WHEN A.estado LIKE '%3%'
			THEN 'Enviando'
		WHEN A.estado LIKE '%4%'
			THEN 'Rechazada'
		WHEN A.estado LIKE '%5%'
			THEN 'Completada'
		ELSE
			'Otros'
		END AS estado
	,A.numero_cuenta
	,CASE 
		WHEN A.numero_cuenta LIKE '%66%'
			THEN 'Online'
		WHEN A.numero_cuenta LIKE '%77%'
			THEN 'Fisica'
		ELSE 
			'Otros'
		END AS tipo_numero_cuenta
	,CASE 
		WHEN A.total_neto < 300
			THEN 'A'
		WHEN A.total_neto < 1500
			THEN 'B'
		WHEN A.total_neto < 4000
			THEN 'C'
		ELSE 'D'
		END AS cluster
--	,C.direccion_linea1
--	,C.direccion_linea2
--	,C.ciudad
--	,C.codigo_postal
	,B.id_detalle
	,B.cantidad
	,B.precio_unitario
	,B.descuento_unitario
FROM tst.vta_pedido AS A
LEFT JOIN tst.vta_pedido_detalle AS B 
	ON	A.id_orden = B.id_orden
	AND A.fecha_pedido>= '2015-02-04'
--INNER JOIN tst,gral_direccion AS C ON CAST(A.id_direccion_envio AS SMALLINT) CAST(C.id_direccion AS SMALLINT)


--sp_help 'tst.vta_pedido_detalle'