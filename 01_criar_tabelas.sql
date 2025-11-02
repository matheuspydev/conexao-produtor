-- ============================================================================
-- SCRIPT DE CRIAÇÃO DAS TABELAS - CONEXÃO PRODUTOR
-- Sistema: Marketplace de Produtos Agropecuários Artesanais
-- ============================================================================

-- Tabela CLIENTE
CREATE TABLE IF NOT EXISTS CLIENTE (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    endereço VARCHAR(200) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

-- Tabela PRODUTOR
CREATE TABLE IF NOT EXISTS PRODUTOR (
    id_produtor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    endereço VARCHAR(200) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

-- Tabela PRODUTO
CREATE TABLE IF NOT EXISTS PRODUTO (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    preço DECIMAL(10, 2) NOT NULL,
    id_produtor INTEGER NOT NULL,
    FOREIGN KEY (id_produtor) REFERENCES PRODUTOR(id_produtor)
);

-- Tabela PEDIDO
CREATE TABLE IF NOT EXISTS PEDIDO (
    id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    data DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    id_cliente INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

-- Tabela ITEM_PEDIDO (Relacionamento N:N entre PEDIDO e PRODUTO)
CREATE TABLE IF NOT EXISTS ITEM_PEDIDO (
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preço DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto)
);

-- Tabela LOGISTICA
CREATE TABLE IF NOT EXISTS LOGISTICA (
    id_logistica INTEGER PRIMARY KEY AUTOINCREMENT,
    data DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    observação TEXT,
    id_pedido INTEGER NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);

-- ============================================================================
-- FIM DO SCRIPT DE CRIAÇÃO
-- ============================================================================

