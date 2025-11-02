# 🌾 Conexão Produtor - Documentação Técnica

## 📋 Sobre o Projeto

Sistema marketplace de produtos agropecuários artesanais que conecta produtores rurais diretamente aos consumidores, comercializando produtos como doce de leite, goiabada, queijos artesanais, mel orgânico e outros itens típicos da produção familiar brasileira.

---

## 🗂️ Estrutura de Arquivos

```
conexão produtor/
├── README.md                           # Este arquivo
├── Consultas_SQL_Atividade3.md        # Documentação oficial da atividade
├── RESULTADOS_REAIS_CONSULTAS.md      # Resultados reais das execuções
├── conexao_produtor.db                # Banco de dados SQLite (gerado)
├── 01_criar_tabelas.sql               # Script DDL - Criação das tabelas
├── 02_inserir_dados.sql               # Script DML - Inserção de dados
├── 03_consulta1.sql                   # Consulta 1: Histórico de Cliente
├── 04_consulta2.sql                   # Consulta 2: Ranking de Produtos
└── 05_consulta3.sql                   # Consulta 3: Status de Entregas
```

---

## 🎯 Como Usar

### Opção 1: Usar o Banco de Dados Já Criado

O banco `conexao_produtor.db` já está populado e pronto para uso.

**Executar as consultas:**

```bash
# Consulta 1 - Histórico de Cliente
sqlite3 conexao_produtor.db < 03_consulta1.sql

# Consulta 2 - Ranking de Produtos
sqlite3 conexao_produtor.db < 04_consulta2.sql

# Consulta 3 - Status de Entregas
sqlite3 conexao_produtor.db < 05_consulta3.sql
```

**Com saída formatada:**

```bash
# Adicionar -header -column para visualização melhor
sqlite3 -header -column conexao_produtor.db < 03_consulta1.sql
```

### Opção 2: Recriar o Banco do Zero

```bash
# 1. Remover banco existente (se houver)
rm -f conexao_produtor.db

# 2. Criar tabelas
sqlite3 conexao_produtor.db < 01_criar_tabelas.sql

# 3. Inserir dados
sqlite3 conexao_produtor.db < 02_inserir_dados.sql

# 4. Executar consultas
sqlite3 -header -column conexao_produtor.db < 03_consulta1.sql
```

### Opção 3: Explorar o Banco Interativamente

```bash
# Abrir o SQLite em modo interativo
sqlite3 conexao_produtor.db

# Comandos úteis dentro do SQLite:
.tables              # Listar todas as tabelas
.schema CLIENTE      # Ver estrutura da tabela CLIENTE
SELECT * FROM PRODUTO LIMIT 5;  # Ver 5 produtos
.quit                # Sair
```

---

## 🗄️ Modelo de Dados

### Entidades

1. **CLIENTE** - Consumidores da plataforma
2. **PRODUTOR** - Produtores rurais/artesãos
3. **PRODUTO** - Produtos agropecuários artesanais
4. **PEDIDO** - Pedidos de compra
5. **ITEM_PEDIDO** - Itens individuais de cada pedido
6. **LOGISTICA** - Informações de entrega/transporte

### Relacionamentos

```
CLIENTE (1) ──── (N) PEDIDO
PRODUTOR (1) ──── (N) PRODUTO
PEDIDO (1) ──── (N) ITEM_PEDIDO
PRODUTO (1) ──── (N) ITEM_PEDIDO
PEDIDO (1) ──── (N) LOGISTICA
```

---

## 📊 As 3 Consultas SQL

### 1️⃣ Consulta 1: Detalhamento de Pedidos por Cliente

**Objetivo:** Visualizar histórico completo de compras de um cliente específico

**Usuários:** Gerentes de venda, atendimento ao cliente

**Retorna:** Lista detalhada de todos os produtos comprados por um cliente, com valores e datas

### 2️⃣ Consulta 2: Ranking de Produtos Mais Vendidos

**Objetivo:** Identificar produtos com maior demanda para planejamento de produção

**Usuários:** Produtores, gerentes comerciais, analistas de negócio

**Retorna:** Top 10 produtos ordenados por quantidade vendida, com receita e preço médio

### 3️⃣ Consulta 3: Status de Entregas Pendentes

**Objetivo:** Monitorar pedidos em processo de entrega

**Usuários:** Equipe de logística, atendimento ao cliente

**Retorna:** Lista de pedidos não entregues com status atual e tempo decorrido

---

## 📦 Dados de Exemplo

O banco contém dados realistas incluindo:

- **7 Clientes** de diferentes cidades de Minas Gerais
- **5 Produtores** rurais (fazendas, sítios, apiário, engenho)
- **16 Produtos** artesanais típicos brasileiros
- **12 Pedidos** com diferentes status
- **Múltiplos itens** por pedido
- **Registros de logística** com diferentes status de entrega

### Produtos Incluídos

- Doce de Leite Tradicional
- Goiabada Cascão
- Queijo Minas Artesanal
- Mel Orgânico
- Geleia de Morango
- Linguiça Artesanal
- Rapadura
- Cachaça Artesanal
- E outros...

---

## 🔧 Requisitos Técnicos

### Para executar os scripts:

- **SQLite 3** (geralmente já instalado em Linux/Mac)

**Verificar instalação:**

```bash
sqlite3 --version
```

**Instalar (se necessário):**

```bash
# Ubuntu/Debian
sudo apt-get install sqlite3

# macOS (com Homebrew)
brew install sqlite3

# Windows
# Baixar de: https://www.sqlite.org/download.html
```

---

## 🎓 Documentação para Entrega

Para a **3ª Atividade**, utilize:

1. **`Consultas_SQL_Atividade3.md`** - Documento principal formatado
2. **`RESULTADOS_REAIS_CONSULTAS.md`** - Comprovação de execução real
3. **Scripts SQL** (01-05) - Código fonte executável
4. **`conexao_produtor.db`** - Banco funcional (opcional demonstrar)

---

## 💡 Diferenciais da Implementação

✅ Banco de dados real e funcional (não apenas mockup)  
✅ Dados realistas de produtos artesanais brasileiros  
✅ Scripts SQL prontos para execução  
✅ Resultados comprovadamente executados  
✅ Documentação completa e profissional  
✅ Integridade referencial implementada (Foreign Keys)  
✅ Consultas otimizadas com JOINs apropriados

---

## 📞 Suporte

Para dúvidas sobre a implementação técnica, consulte:

- Documentação SQLite: https://www.sqlite.org/docs.html
- SQL Tutorial: https://www.w3schools.com/sql/

---

**Projeto:** Conexão Produtor  
**Disciplina:** Trabalho Interdisciplinar de Aplicações Web  
**Instituição:** PUC Minas  
**Data:** Novembro 2025
