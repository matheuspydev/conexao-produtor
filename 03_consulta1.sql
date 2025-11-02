-- CONSULTA 1: Detalhamento de Pedidos por Cliente

SELECT 
    c.nome AS nome_cliente,
    c.cpf,
    p.id_pedido,
    p.data AS data_pedido,
    p.status AS status_pedido,
    prod.nome AS produto,
    prod.tipo AS tipo_produto,
    pr.nome AS produtor,
    ip.quantidade,
    ip.preço AS preço_unitario,
    (ip.quantidade * ip.preço) AS subtotal,
    p.valor_total
FROM 
    CLIENTE c
    INNER JOIN PEDIDO p ON c.id_cliente = p.id_cliente
    INNER JOIN ITEM_PEDIDO ip ON p.id_pedido = ip.id_pedido
    INNER JOIN PRODUTO prod ON ip.id_produto = prod.id_produto
    INNER JOIN PRODUTOR pr ON prod.id_produtor = pr.id_produtor
WHERE 
    c.id_cliente = 1  -- Maria Silva
ORDER BY 
    p.data DESC, p.id_pedido, prod.nome;

