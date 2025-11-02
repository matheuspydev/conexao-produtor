# 3ª Atividade: Consultas SQL - Conexão Produtor

## Informações do Projeto

**Sistema:** Marketplace de Produtos Agropecuários Artesanais  
**Nome:** Conexão Produtor  
**Data:** Novembro de 2025

---

## Modelo de Dados

O sistema possui as seguintes entidades:

### Tabelas

- **CLIENTE**: id_cliente (PK), nome, cpf, endereço, telefone
- **PRODUTOR**: id_produtor (PK), nome, cnpj, endereço, telefone
- **PRODUTO**: id_produto (PK), nome, tipo, preço, id_produtor (FK)
- **PEDIDO**: id_pedido (PK), data, status, valor_total, id_cliente (FK)
- **ITEM_PEDIDO**: id_pedido (PK, FK), id_produto (PK, FK), quantidade, preço
- **LOGISTICA**: id_logistica (PK), data, status, observação, id_pedido (FK)

---

## CONSULTA 1: Detalhamento de Pedidos por Cliente

### Necessidade Informacional

**Processo:** Venda  
**Usuários:** Gerentes de venda, atendimento ao cliente  
**Objetivo:** Visualizar o histórico completo de compras de um cliente específico, incluindo todos os produtos adquiridos, quantidades e valores, para melhor atendimento e análise de perfil de compra.

### Consulta SQL

```sql
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
    c.id_cliente = 1  -- Exemplo: cliente específico
ORDER BY
    p.data DESC, p.id_pedido, prod.nome;
```

### Resultado Previsto

| nome_cliente | cpf            | id_pedido | data_pedido | status_pedido | produto                   | tipo_produto | produtor               | quantidade | preço_unitario | subtotal | valor_total |
| ------------ | -------------- | --------- | ----------- | ------------- | ------------------------- | ------------ | ---------------------- | ---------- | -------------- | -------- | ----------- |
| Maria Silva  | 123.456.789-00 | 3         | 2025-11-01  | Entregue      | Doce de Leite Tradicional | Doces        | Fazenda Vale Verde     | 2          | 25.00          | 50.00    | 95.00       |
| Maria Silva  | 123.456.789-00 | 3         | 2025-11-01  | Entregue      | Queijo Minas Artesanal    | Laticínios   | Fazenda Vale Verde     | 1          | 45.00          | 45.00    | 95.00       |
| Maria Silva  | 123.456.789-00 | 1         | 2025-10-15  | Entregue      | Goiabada Cascão           | Doces        | Sítio Frutas do Campo  | 3          | 18.00          | 54.00    | 104.00      |
| Maria Silva  | 123.456.789-00 | 1         | 2025-10-15  | Entregue      | Mel Orgânico              | Apicultura   | Apiário Flores Nativas | 1          | 50.00          | 50.00    | 104.00      |

**Interpretação do Resultado:**  
A cliente Maria Silva realizou 2 pedidos. O pedido mais recente (ID 3, de 01/11/2025) totalizou R$ 95,00 e incluiu doce de leite e queijo. O pedido anterior (ID 1, de 15/10/2025) totalizou R$ 104,00 com goiabada e mel. Todos os pedidos foram entregues com sucesso.

---

## CONSULTA 2: Ranking de Produtos Mais Vendidos por Produtor

### Necessidade Informacional

**Processo:** Venda  
**Usuários:** Produtores, gerentes comerciais, analistas de negócio  
**Objetivo:** Identificar quais produtos artesanais têm maior demanda para otimizar o planejamento de produção, gestão de estoque e estratégias de marketing.

### Consulta SQL

```sql
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
```

### Resultado Previsto

| produto                   | tipo       | produtor               | cnpj               | quantidade_total_vendida | numero_pedidos | receita_total | preço_medio |
| ------------------------- | ---------- | ---------------------- | ------------------ | ------------------------ | -------------- | ------------- | ----------- |
| Doce de Leite Tradicional | Doces      | Fazenda Vale Verde     | 12.345.678/0001-90 | 45                       | 18             | 1125.00       | 25.00       |
| Goiabada Cascão           | Doces      | Sítio Frutas do Campo  | 23.456.789/0001-80 | 38                       | 15             | 684.00        | 18.00       |
| Queijo Minas Artesanal    | Laticínios | Fazenda Vale Verde     | 12.345.678/0001-90 | 32                       | 14             | 1440.00       | 45.00       |
| Geleia de Morango         | Conservas  | Sítio Frutas do Campo  | 23.456.789/0001-80 | 28                       | 12             | 420.00        | 15.00       |
| Mel Orgânico              | Apicultura | Apiário Flores Nativas | 34.567.890/0001-70 | 25                       | 10             | 1250.00       | 50.00       |
| Doce de Abóbora           | Doces      | Fazenda Sabor Rural    | 45.678.901/0001-60 | 22                       | 11             | 440.00        | 20.00       |
| Linguiça Artesanal        | Embutidos  | Fazenda Vale Verde     | 12.345.678/0001-90 | 20                       | 8              | 700.00        | 35.00       |
| Rapadura                  | Doces      | Engenho Cana Doce      | 56.789.012/0001-50 | 18                       | 9              | 180.00        | 10.00       |
| Requeijão Caseiro         | Laticínios | Fazenda Vale Verde     | 12.345.678/0001-90 | 15                       | 7              | 375.00        | 25.00       |
| Cachaça Artesanal         | Bebidas    | Engenho Cana Doce      | 56.789.012/0001-50 | 12                       | 6              | 720.00        | 60.00       |

**Interpretação do Resultado:**  
O produto mais vendido é o Doce de Leite Tradicional (45 unidades em 18 pedidos), gerando R$ 1.125,00 de receita. A Fazenda Vale Verde é o produtor com maior destaque, aparecendo com 4 produtos no top 10. O Queijo Minas Artesanal, apesar de ter menos unidades vendidas que a Goiabada, gera maior receita (R$ 1.440,00) devido ao seu preço mais alto.

---

## CONSULTA 3: Status de Entregas Pendentes

### Necessidade Informacional

**Processo:** Logística/Transportadora  
**Usuários:** Equipe de logística, atendimento ao cliente, clientes  
**Objetivo:** Monitorar em tempo real todos os pedidos que estão em processo de entrega, permitindo acompanhamento proativo, identificação de atrasos e comunicação eficiente com clientes.

### Consulta SQL

```sql
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
    DATEDIFF(CURRENT_DATE, l.data) AS dias_desde_envio
FROM
    LOGISTICA l
    INNER JOIN PEDIDO p ON l.id_pedido = p.id_pedido
    INNER JOIN CLIENTE c ON p.id_cliente = c.id_cliente
WHERE
    l.status IN ('Aguardando Coleta', 'Em Trânsito', 'Saiu para Entrega')
ORDER BY
    l.data ASC, l.status;
```

### Resultado Previsto

| id_logistica | id_pedido | cliente         | telefone_cliente | endereço_entrega                         | data_pedido | valor_total | data_logistica | status_entrega    | observação                                               | dias_desde_envio |
| ------------ | --------- | --------------- | ---------------- | ---------------------------------------- | ----------- | ----------- | -------------- | ----------------- | -------------------------------------------------------- | ---------------- |
| 5            | 5         | João Santos     | (31) 98765-4321  | Rua das Flores, 123, Belo Horizonte - MG | 2025-10-28  | 135.00      | 2025-10-29     | Em Trânsito       | Transportadora: Logística Express - Previsão: 05/11/2025 | 4                |
| 7            | 7         | Ana Paula Costa | (31) 99123-4567  | Av. Brasil, 456, Contagem - MG           | 2025-10-30  | 89.00       | 2025-10-31     | Aguardando Coleta | Aguardando coleta pela transportadora                    | 2                |
| 8            | 8         | Carlos Oliveira | (31) 97654-3210  | Rua Minas Gerais, 789, Betim - MG        | 2025-11-01  | 220.00      | 2025-11-01     | Saiu para Entrega | Entrega prevista para hoje até 18h                       | 1                |
| 9            | 9         | Fernanda Lima   | (31) 96543-2109  | Rua São Paulo, 321, Nova Lima - MG       | 2025-11-01  | 175.00      | 2025-11-02     | Em Trânsito       | Transportadora: Rápido Entrega - Previsão: 04/11/2025    | 0                |

**Interpretação do Resultado:**  
Há 4 pedidos em processo de entrega. O pedido 5 (João Santos) está em trânsito há 4 dias, com previsão de entrega em 05/11. O pedido 8 (Carlos Oliveira) está em fase crítica "Saiu para Entrega" com previsão para hoje. O pedido 7 (Ana Paula) ainda aguarda coleta há 2 dias, necessitando atenção da equipe de logística. O pedido 9 (Fernanda) foi despachado recentemente (hoje) e está em trânsito normal.

---

## Conclusão

As três consultas SQL desenvolvidas atendem às necessidades informacionais dos processos de **Venda** e **Logística/Transportadora** do sistema Conexão Produtor:

1. **Consulta 1** permite análise individualizada do histórico de compras de clientes
2. **Consulta 2** fornece insights estratégicos sobre desempenho de produtos e produtores
3. **Consulta 3** garante controle operacional efetivo das entregas em andamento

Estas consultas suportam a tomada de decisão em diferentes níveis (operacional, tático e estratégico) e beneficiam múltiplos stakeholders do sistema.
