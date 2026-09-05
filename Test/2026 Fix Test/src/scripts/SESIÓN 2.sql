USE Martinexsa
GO

/*
SELECT  t.name AS nombre_tabla
        , c.name AS nombre_columna
FROM    sys.columns c
INNER JOIN sys.tables t
        ON c.object_id = t.object_id
WHERE   c.name = 'id_metodo_envio'
ORDER BY t.name;
*/

-- 1.
-------------------------------------------------------------------------------
SELECT  TOP (5)
        A.id_orden 
        , A.fecha_pedido 
        , A.estado 
        , A.numero_cuenta 
        , A.sub_total 
        , A.impuestos 
        , A.flete 
        , A.total_neto 
        --, A.nombre 
        --, A.base_envio 
FROM    tst.vta_pedido A
    -- La table gral_metodo_envio no existe o no venia en el paquete e pruebas
    -- JOIN tst.gral_metodo_envio AS B 
WHERE   A.total_neto > 1000 
    OR  A.total_neto < 500  -- Cambie el AND por OR si la intencion era ver los rangos expteriores.
ORDER BY A.fecha_pedido DESC

-- 2.
-------------------------------------------------------------------------------
SELECT 
    A.id_orden
  , A.fecha_pedido
  , CASE 
        -- cambie a comparación directa en lugar de LIKE con comodines
        WHEN A.estado = '1' THEN 'Iniciando'
        WHEN A.estado = '2' THEN 'Procesando'
        WHEN A.estado = '3' THEN 'Enviando'
        WHEN A.estado = '4' THEN 'Rechazada'
        WHEN A.estado = '5' THEN 'Completada'
        ELSE 'Otros'
    END AS estado
  , A.numero_cuenta
  , CASE 
        -- Puse comillas en el patrón LIKE y se diferenciaron condiciones
        -- quite el - inicial aunque hay que consultar formato de cuentas
        WHEN A.numero_cuenta LIKE '%66-%' THEN 'Online'
        WHEN A.numero_cuenta LIKE '%77-%' THEN 'Fisica' -- puse numero X por que se repetia 66 (consultar numero correcto)
        ELSE 'Otros'
    END AS tipo_numero_cuenta
  , CASE 
        WHEN A.total_neto < 300 THEN 'A'
        WHEN A.total_neto >= 300 AND A.total_neto < 1500 THEN 'B'
        WHEN A.total_neto >= 1500 AND A.total_neto < 4000 THEN 'C'
        ELSE 'D'
    END AS cluster
  --, C.direccion_linea1
  --, C.direccion_linea2
  --, C.ciudad
  --, C.codigo_postal
  , B.id_detalle
  , B.cantidad
  , B.precio_unitario
  , B.descuento_unitario
FROM tst.vta_pedido AS A
  LEFT JOIN tst.vta_pedido_detalle AS B
        -- Corrección: eliminar ISNULL en la condición de JOIN, basta con igualdad directa
        ON A.id_orden = B.id_orden
        -- Corrección: eliminar CAST innecesario, comparar directamente con fecha
 --      AND A.fecha_pedido >= '2015-02-04'
  -- La table gral_direccion no existe o no venia en el paquete e pruebas
  -- INNER JOIN tst.gral_direccion AS C
        -- Corrección: eliminar CAST redundante en JOIN con gral_direccion
        -- ON A.id_direccion_envio = C.id_direccion;