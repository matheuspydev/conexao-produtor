-- CONSULTA 2: Ranking de Produtos Mais Vendidos por Produtor

SELECT 
    prod.nome AS produto,
    prod.tipo,
    pr.nome AS produtor,
    pr.cnpj,
    SUM(ip.quantidade) AS quantidade_total_vendida,
    COUNT(DISTINCT ip.id_pedido) AS numero_pedidos,
    SUM(ip.quantidade * ip.preço) AS receita_total,
    ROUND(AVG(ip.preço), 2) AS preço_medio
FROM 
    PRODUTO prod
    INNER JOIN PRODUTOR pr ON prod.id_produtor = pr.id_produtor
    INNER JOIN ITEM_PEDIDO ip ON prod.id_produto = ip.id_produto
    INNER JOIN PEDIDO p ON ip.id_pedido = p.id_pedido
WHERE 
    p.status IN ('Confirmado', 'Em Separação', 'Enviado', 'Entregue')
GROUP BY 
    prod.id_produto, prod.nome, prod.tipo, pr.nome, pr.cnpj
ORDER BY 
    quantidade_total_vendida DESC, receita_total DESC
LIMIT 10;

