# 🌾 Conexão Produtor - Atividade 3: Consultas SQL

[![SQLite](https://img.shields.io/badge/SQLite-3-blue.svg)](https://www.sqlite.org/)
[![Status](https://img.shields.io/badge/Status-Completo-success.svg)]()
[![Disciplina](https://img.shields.io/badge/Disciplina-TI%20Aplica%C3%A7%C3%B5es%20Web-orange.svg)]()

> Sistema marketplace de produtos agropecuários artesanais com banco de dados relacional funcional

## 📋 Sobre o Projeto

**Conexão Produtor** é um marketplace que conecta produtores rurais diretamente aos consumidores, comercializando produtos artesanais como:
- 🥛 Doce de Leite Tradicional
- 🍓 Goiabada Cascão
- 🧀 Queijo Minas Artesanal
- 🍯 Mel Orgânico
- 🥓 Linguiça Artesanal
- E muito mais...

## 🎯 Objetivo da Atividade

Desenvolver **3 consultas SQL** baseadas nas necessidades informacionais dos processos de **Venda** e **Logística**, com banco de dados funcional e resultados comprovados.

## ✨ Diferenciais da Implementação

✅ **Banco de dados SQLite REAL** (não apenas mockup)  
✅ **Resultados comprovadamente executados**  
✅ **Scripts SQL prontos para rodar**  
✅ **Dados realistas** de produtos artesanais brasileiros  
✅ **Documentação completa** e profissional  
✅ **16 produtos** de 5 produtores diferentes  
✅ **Integridade referencial** implementada (Foreign Keys)  

## 📊 Modelo de Dados

```
CLIENTE (1) ──── (N) PEDIDO (1) ──── (N) ITEM_PEDIDO (N) ──── (1) PRODUTO (N) ──── (1) PRODUTOR
                           │
                           └─── (N) LOGISTICA
```

### Tabelas Implementadas

- **CLIENTE**: 7 clientes de cidades de Minas Gerais
- **PRODUTOR**: 5 produtores rurais (fazendas, sítios, apiário)
- **PRODUTO**: 16 produtos agropecuários artesanais
- **PEDIDO**: 12 pedidos com diferentes status
- **ITEM_PEDIDO**: ~30 itens (relacionamento N:N)
- **LOGISTICA**: 12 registros de entrega/transporte

## 🔍 As 3 Consultas SQL

### 1️⃣ Detalhamento de Pedidos por Cliente

**Processo:** Venda  
**Objetivo:** Visualizar histórico completo de compras de um cliente

```sql
-- JOIN de 5 tabelas: CLIENTE → PEDIDO → ITEM_PEDIDO → PRODUTO → PRODUTOR
SELECT c.nome, p.id_pedido, p.data, prod.nome AS produto, 
       ip.quantidade, ip.preço, (ip.quantidade * ip.preço) AS subtotal
FROM CLIENTE c
INNER JOIN PEDIDO p ON c.id_cliente = p.id_cliente
INNER JOIN ITEM_PEDIDO ip ON p.id_pedido = ip.id_pedido
INNER JOIN PRODUTO prod ON ip.id_produto = prod.id_produto
WHERE c.id_cliente = 1
ORDER BY p.data DESC;
```

**Resultado:** 6 registros | Cliente gastou R$ 284,00 em 3 pedidos

### 2️⃣ Ranking de Produtos Mais Vendidos

**Processo:** Venda  
**Objetivo:** Identificar produtos com maior demanda

```sql
-- Agregação com SUM, COUNT e AVG
SELECT prod.nome, SUM(ip.quantidade) AS total_vendido,
       COUNT(DISTINCT ip.id_pedido) AS num_pedidos,
       SUM(ip.quantidade * ip.preço) AS receita_total
FROM PRODUTO prod
INNER JOIN ITEM_PEDIDO ip ON prod.id_produto = ip.id_produto
GROUP BY prod.id_produto
ORDER BY total_vendido DESC
LIMIT 10;
```

**Resultado:** Doce de Leite lidera com 16 unidades vendidas (R$ 400,00)

### 3️⃣ Status de Entregas Pendentes

**Processo:** Logística/Transportadora  
**Objetivo:** Monitorar pedidos em processo de entrega

```sql
-- Cálculo de dias desde envio + filtro de status
SELECT l.id_pedido, c.nome AS cliente, l.status,
       l.observação, 
       julianday(CURRENT_DATE) - julianday(l.data) AS dias_desde_envio
FROM LOGISTICA l
INNER JOIN PEDIDO p ON l.id_pedido = p.id_pedido
INNER JOIN CLIENTE c ON p.id_cliente = c.id_cliente
WHERE l.status IN ('Aguardando Coleta', 'Em Trânsito', 'Saiu para Entrega')
ORDER BY l.data ASC;
```

**Resultado:** 4 entregas em andamento (R$ 619,00 em trânsito)

## 🚀 Como Usar

### Pré-requisitos

- SQLite 3 (geralmente já instalado em Mac/Linux)

```bash
# Verificar instalação
sqlite3 --version
```

### Executar as Consultas

```bash
# Clone o repositório
git clone [URL-DO-SEU-REPOSITORIO]
cd "conexão produtor"

# Executar consultas (o banco já está criado e populado)
sqlite3 -header -column conexao_produtor.db < 03_consulta1.sql
sqlite3 -header -column conexao_produtor.db < 04_consulta2.sql
sqlite3 -header -column conexao_produtor.db < 05_consulta3.sql
```

### Recriar o Banco do Zero

```bash
# Remover banco existente
rm -f conexao_produtor.db

# Criar e popular
sqlite3 conexao_produtor.db < 01_criar_tabelas.sql
sqlite3 conexao_produtor.db < 02_inserir_dados.sql

# Executar consultas
sqlite3 -header -column conexao_produtor.db < 03_consulta1.sql
```

### Explorar Interativamente

```bash
sqlite3 conexao_produtor.db

.tables                          # Listar tabelas
.schema PRODUTO                  # Ver estrutura de uma tabela
SELECT * FROM PRODUTO LIMIT 5;   # Ver 5 produtos
.quit                            # Sair
```

## 📁 Estrutura do Projeto

```
conexão-produtor/
├── README.md                        # Este arquivo
├── Consultas_SQL_Atividade3.md     # Documentação oficial da atividade
├── RESULTADOS_REAIS_CONSULTAS.md   # Resultados reais executados
├── RESUMO_EXECUTIVO.md             # Resumo executivo
├── conexao_produtor.db             # Banco de dados SQLite (44 KB)
├── 01_criar_tabelas.sql            # DDL - Criação das tabelas
├── 02_inserir_dados.sql            # DML - Inserção de dados
├── 03_consulta1.sql                # Consulta: Histórico de Cliente
├── 04_consulta2.sql                # Consulta: Ranking de Produtos
└── 05_consulta3.sql                # Consulta: Status de Entregas
```

## 📊 Estatísticas do Banco

| Métrica | Valor |
|---------|-------|
| Tabelas | 6 |
| Clientes | 7 |
| Produtores | 5 |
| Produtos | 16 |
| Pedidos | 12 |
| Itens de Pedido | ~30 |
| Registros de Logística | 12 |
| Tamanho do Banco | 44 KB |

## 🎓 Documentação para Avaliação

Para avaliação da **3ª Atividade**, consulte:

1. **`Consultas_SQL_Atividade3.md`** - Documento principal formatado
2. **`RESULTADOS_REAIS_CONSULTAS.md`** - Comprovação de execução
3. **Scripts SQL** (01-05) - Código fonte executável
4. **`conexao_produtor.db`** - Banco funcional para demonstração

## 💡 Insights de Negócio

### Vendas
- 🏆 Produto mais vendido: Doce de Leite (16 unidades)
- 💰 Maior receita: Doce de Leite (R$ 400,00)
- 🏭 Produtor destaque: Fazenda Vale Verde (3 produtos no top 10)

### Logística
- 📦 33% dos pedidos em trânsito (4 de 12)
- ⏱️ Tempo médio de entrega: 2-4 dias
- ⚠️ 1 pedido necessita atenção (aguardando coleta há 2 dias)

### Clientes
- 🛒 Ticket médio: ~R$ 95,00 por pedido
- 🔄 Cliente mais ativo: 3 pedidos em 18 dias
- 📍 Região principal: Grande BH (MG)

## 🛠️ Tecnologias Utilizadas

- **SQLite 3** - Banco de dados relacional
- **SQL** - Linguagem de consulta
- **Markdown** - Documentação
- **Git** - Controle de versão

## 👨‍💻 Autor

**Matheus Henrique**  
**Julia Laine**

PUC Minas - Trabalho Interdisciplinar de Aplicações Web  
Novembro 2025

## 📝 Licença

Este projeto foi desenvolvido para fins acadêmicos.

---

⭐ **Se este projeto foi útil, deixe uma estrela!**

🌾 **Conexão Produtor** - Conectando o campo à mesa com tecnologia! 🌾

