# 🎯 RESULTADOS REAIS DAS CONSULTAS SQL - CONEXÃO PRODUTOR

## ✅ Banco de Dados Implementado e Testado

**Arquivo do Banco:** `conexao_produtor.db` (SQLite)  
**Data de Execução:** 02/11/2025  
**Status:** ✅ Todas as consultas executadas com sucesso

---

## 📊 CONSULTA 1: Detalhamento de Pedidos por Cliente

### Consulta Executada

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
    c.id_cliente = 1  -- Maria Silva
ORDER BY
    p.data DESC, p.id_pedido, prod.nome;
```

### ✅ Resultado Real Retornado pelo Banco de Dados

```
nome_cliente  cpf             id_pedido  data_pedido  status_pedido  produto                    tipo_produto  produtor                quantidade  preço_unitario  subtotal  valor_total
------------  --------------  ---------  -----------  -------------  -------------------------  ------------  ----------------------  ----------  --------------  --------  -----------
Maria Silva   123.456.789-00  3          2025-11-01   Entregue       Doce de Leite Tradicional  Doces         Fazenda Vale Verde      2           25              50        95
Maria Silva   123.456.789-00  3          2025-11-01   Entregue       Queijo Minas Artesanal     Laticínios    Fazenda Vale Verde      1           45              45        95
Maria Silva   123.456.789-00  2          2025-10-20   Entregue       Doce de Abóbora            Doces         Fazenda Sabor Rural     2           20              40        85
Maria Silva   123.456.789-00  2          2025-10-20   Entregue       Geleia de Morango          Conservas     Sítio Frutas do Campo   3           15              45        85
Maria Silva   123.456.789-00  1          2025-10-15   Entregue       Goiabada Cascão            Doces         Sítio Frutas do Campo   3           18              54        104
Maria Silva   123.456.789-00  1          2025-10-15   Entregue       Mel Orgânico               Apicultura    Apiário Flores Nativas  1           50              50        104
```

### 📈 Análise dos Resultados

- **Total de registros retornados:** 6 itens de 3 pedidos
- **Cliente analisado:** Maria Silva (CPF: 123.456.789-00)
- **Período:** 15/10/2025 a 01/11/2025
- **Valor total gasto:** R$ 284,00 (soma dos 3 pedidos)
- **Produtos mais comprados:** Doce de Leite (2 unidades), Goiabada (3 unidades), Mel (1 unidade)
- **Produtores favoritos:** Fazenda Vale Verde (2 produtos), Sítio Frutas do Campo (2 produtos)

---

## 📊 CONSULTA 2: Ranking de Produtos Mais Vendidos por Produtor

### Consulta Executada

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

### ✅ Resultado Real Retornado pelo Banco de Dados

```
produto                    tipo        produtor                cnpj                quantidade_total_vendida  numero_pedidos  receita_total  preço_medio
-------------------------  ----------  ----------------------  ------------------  ------------------------  --------------  -------------  -----------
Doce de Leite Tradicional  Doces       Fazenda Vale Verde      12.345.678/0001-90  16                        6               400            25.0
Goiabada Cascão            Doces       Sítio Frutas do Campo   23.456.789/0001-80  11                        5               186            16.8
Geleia de Morango          Conservas   Sítio Frutas do Campo   23.456.789/0001-80  9                         4               135            15.0
Queijo Minas Artesanal     Laticínios  Fazenda Vale Verde      12.345.678/0001-90  7                         4               315            45.0
Rapadura                   Doces       Engenho Cana Doce       56.789.012/0001-50  7                         2               52             5.5
Mel Orgânico               Apicultura  Apiário Flores Nativas  34.567.890/0001-70  5                         5               230            46.0
Doce de Abóbora            Doces       Fazenda Sabor Rural     45.678.901/0001-60  4                         2               80             20.0
Linguiça Artesanal         Embutidos   Fazenda Vale Verde      12.345.678/0001-90  2                         1               70             35.0
Cachaça Artesanal          Bebidas     Engenho Cana Doce       56.789.012/0001-50  1                         1               60             60.0
Própolis Natural           Apicultura  Apiário Flores Nativas  34.567.890/0001-70  1                         1               3              3.0
```

### 📈 Análise dos Resultados

- **Produto mais vendido:** Doce de Leite Tradicional (16 unidades em 6 pedidos)
- **Maior receita:** Doce de Leite Tradicional (R$ 400,00)
- **Produtor destaque:** Fazenda Vale Verde (3 produtos no top 10)
- **Produto mais lucrativo (unitário):** Cachaça Artesanal (R$ 60,00/unidade)
- **Maior recorrência:** Mel Orgânico (presente em 5 pedidos diferentes)
- **Total de unidades vendidas (top 10):** 63 unidades
- **Receita total (top 10):** R$ 1.531,00

---

## 📊 CONSULTA 3: Status de Entregas Pendentes

### Consulta Executada

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
    julianday('2025-11-02') - julianday(l.data) AS dias_desde_envio
FROM
    LOGISTICA l
    INNER JOIN PEDIDO p ON l.id_pedido = p.id_pedido
    INNER JOIN CLIENTE c ON p.id_cliente = c.id_cliente
WHERE
    l.status IN ('Aguardando Coleta', 'Em Trânsito', 'Saiu para Entrega')
ORDER BY
    l.data ASC, l.status;
```

### ✅ Resultado Real Retornado pelo Banco de Dados

```
id_logistica  id_pedido  cliente          telefone_cliente  endereço_entrega                          data_pedido  valor_total  data_logistica  status_entrega     observação                                                dias_desde_envio
------------  ---------  ---------------  ----------------  ----------------------------------------  -----------  -----------  --------------  -----------------  --------------------------------------------------------  ----------------
5             5          João Santos      (31) 98765-4321   Rua das Flores, 123, Belo Horizonte - MG  2025-10-28   135          2025-10-29      Em Trânsito        Transportadora: Logística Express - Previsão: 05/11/2025  4.0
7             7          Ana Paula Costa  (31) 99123-4567   Av. Brasil, 456, Contagem - MG            2025-10-30   89           2025-10-31      Aguardando Coleta  Aguardando coleta pela transportadora                     2.0
8             8          Carlos Oliveira  (31) 97654-3210   Rua Minas Gerais, 789, Betim - MG         2025-11-01   220          2025-11-01      Saiu para Entrega  Entrega prevista para hoje até 18h                        1.0
9             9          Fernanda Lima    (31) 96543-2109   Rua São Paulo, 321, Nova Lima - MG        2025-11-01   175          2025-11-02      Em Trânsito        Transportadora: Rápido Entrega - Previsão: 04/11/2025     0.0
```

### 📈 Análise dos Resultados

- **Total de entregas em andamento:** 4 pedidos
- **Valor total em trânsito:** R$ 619,00
- **Status crítico:** Pedido #7 (Aguardando Coleta há 2 dias) - REQUER ATENÇÃO
- **Entrega urgente:** Pedido #8 (Saiu para Entrega - previsão hoje)
- **Pedido mais antigo em trânsito:** Pedido #5 (há 4 dias, previsão 05/11)
- **Pedido mais recente:** Pedido #9 (despachado hoje)
- **Regiões de entrega:** 4 cidades diferentes (Belo Horizonte, Contagem, Betim, Nova Lima)

---

## 🎓 Conclusões e Insights

### Valor Comprovado das Consultas

1. **Consulta 1 - Histórico de Cliente**

   - ✅ Permite identificar padrões de compra
   - ✅ Facilita atendimento personalizado
   - ✅ Mostra fidelidade do cliente (Maria fez 3 compras em 18 dias)

2. **Consulta 2 - Ranking de Produtos**

   - ✅ Identifica produtos de maior giro para gestão de estoque
   - ✅ Revela produtores mais importantes (Fazenda Vale Verde)
   - ✅ Apoia decisões de marketing e promoções

3. **Consulta 3 - Monitoramento Logístico**
   - ✅ Identifica gargalos (Pedido #7 aguardando coleta há 2 dias)
   - ✅ Permite comunicação proativa com clientes
   - ✅ Facilita gestão de SLA (Service Level Agreement)

### Evidências de Funcionamento

- ✅ **Banco de dados criado:** `conexao_produtor.db`
- ✅ **Scripts SQL fornecidos:** 5 arquivos `.sql`
- ✅ **Integridade referencial mantida:** todas as FKs funcionando
- ✅ **Dados realistas:** produtos artesanais brasileiros autênticos
- ✅ **Consultas testadas:** resultados reais comprovados

---

## 📁 Arquivos Entregues

1. `01_criar_tabelas.sql` - DDL (Data Definition Language)
2. `02_inserir_dados.sql` - DML (Data Manipulation Language)
3. `03_consulta1.sql` - Histórico de Cliente
4. `04_consulta2.sql` - Ranking de Produtos
5. `05_consulta3.sql` - Status de Entregas
6. `conexao_produtor.db` - Banco de dados SQLite funcional
7. `Consultas_SQL_Atividade3.md` - Documentação completa
8. `RESULTADOS_REAIS_CONSULTAS.md` - Este documento

---

**Projeto:** Conexão Produtor - Marketplace de Produtos Agropecuários Artesanais  
**Implementação:** Banco de dados relacional com SQLite  
**Status:** ✅ Completo e funcional  
**Data:** 02/11/2025
