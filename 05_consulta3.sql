-- CONSULTA 3: Status de Entregas Pendentes

SELECT 
    l.id_logistica,
    p.id_pedido,
    c.nome AS cliente,
    c.telefone AS telefone_cliente,
    c.endereço AS endereço_entrega,
    p.data AS data_pedido,
    p.valor_total,
    l.data AS data_logistica,
    l.status AS status_entrega,
    l.observação,
    julianday('2025-11-02') - julianday(l.data) AS dias_desde_envio
FROM 
    LOGISTICA l
    INNER JOIN PEDIDO p ON l.id_pedido = p.id_pedido
    INNER JOIN CLIENTE c ON p.id_cliente = c.id_cliente
WHERE 
    l.status IN ('Aguardando Coleta', 'Em Trânsito', 'Saiu para Entrega')
ORDER BY 
    l.data ASC, l.status;

