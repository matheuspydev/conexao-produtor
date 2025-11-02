-- ============================================================================
-- SCRIPT DE INSERÇÃO DE DADOS - CONEXÃO PRODUTOR
-- Sistema: Marketplace de Produtos Agropecuários Artesanais
-- ============================================================================

-- Inserir CLIENTES
INSERT INTO CLIENTE (nome, cpf, endereço, telefone) VALUES
('Maria Silva', '123.456.789-00', 'Rua das Acácias, 100, Belo Horizonte - MG', '(31) 99999-1111'),
('João Santos', '234.567.890-11', 'Rua das Flores, 123, Belo Horizonte - MG', '(31) 98765-4321'),
('Ana Paula Costa', '345.678.901-22', 'Av. Brasil, 456, Contagem - MG', '(31) 99123-4567'),
('Carlos Oliveira', '456.789.012-33', 'Rua Minas Gerais, 789, Betim - MG', '(31) 97654-3210'),
('Fernanda Lima', '567.890.123-44', 'Rua São Paulo, 321, Nova Lima - MG', '(31) 96543-2109'),
('Pedro Almeida', '678.901.234-55', 'Av. Afonso Pena, 555, Belo Horizonte - MG', '(31) 95432-1098'),
('Juliana Rocha', '789.012.345-66', 'Rua Rio de Janeiro, 777, Contagem - MG', '(31) 94321-0987');

-- Inserir PRODUTORES
INSERT INTO PRODUTOR (nome, cnpj, endereço, telefone) VALUES
('Fazenda Vale Verde', '12.345.678/0001-90', 'Zona Rural, km 15, Tiradentes - MG', '(32) 3355-1000'),
('Sítio Frutas do Campo', '23.456.789/0001-80', 'Estrada do Campo, s/n, São João del-Rei - MG', '(32) 3355-2000'),
('Apiário Flores Nativas', '34.567.890/0001-70', 'Rodovia MG-383, km 20, Carrancas - MG', '(35) 3344-3000'),
('Fazenda Sabor Rural', '45.678.901/0001-60', 'Fazenda Boa Vista, Lavras - MG', '(35) 3821-4000'),
('Engenho Cana Doce', '56.789.012/0001-50', 'Estrada do Engenho, km 8, Mariana - MG', '(31) 3557-5000');

-- Inserir PRODUTOS
INSERT INTO PRODUTO (nome, tipo, preço, id_produtor) VALUES
-- Produtos da Fazenda Vale Verde (id_produtor = 1)
('Doce de Leite Tradicional', 'Doces', 25.00, 1),
('Queijo Minas Artesanal', 'Laticínios', 45.00, 1),
('Requeijão Caseiro', 'Laticínios', 25.00, 1),
('Linguiça Artesanal', 'Embutidos', 35.00, 1),
-- Produtos do Sítio Frutas do Campo (id_produtor = 2)
('Goiabada Cascão', 'Doces', 18.00, 2),
('Geleia de Morango', 'Conservas', 15.00, 2),
('Geleia de Amora', 'Conservas', 15.00, 2),
('Doce de Figo', 'Doces', 22.00, 2),
-- Produtos do Apiário Flores Nativas (id_produtor = 3)
('Mel Orgânico', 'Apicultura', 50.00, 3),
('Própolis Natural', 'Apicultura', 35.00, 3),
-- Produtos da Fazenda Sabor Rural (id_produtor = 4)
('Doce de Abóbora', 'Doces', 20.00, 4),
('Doce de Mamão', 'Doces', 20.00, 4),
('Geleia de Pimenta', 'Conservas', 18.00, 4),
-- Produtos do Engenho Cana Doce (id_produtor = 5)
('Rapadura', 'Doces', 10.00, 5),
('Melado de Cana', 'Doces', 12.00, 5),
('Cachaça Artesanal', 'Bebidas', 60.00, 5);

-- Inserir PEDIDOS
INSERT INTO PEDIDO (data, status, valor_total, id_cliente) VALUES
-- Pedidos da Maria Silva (id_cliente = 1)
('2025-10-15', 'Entregue', 104.00, 1),
('2025-10-20', 'Entregue', 85.00, 1),
('2025-11-01', 'Entregue', 95.00, 1),
-- Pedidos de outros clientes
('2025-10-25', 'Entregue', 150.00, 2),
('2025-10-28', 'Enviado', 135.00, 2),
('2025-10-22', 'Entregue', 95.00, 3),
('2025-10-30', 'Confirmado', 89.00, 3),
('2025-11-01', 'Em Separação', 220.00, 4),
('2025-11-01', 'Enviado', 175.00, 5),
('2025-10-18', 'Entregue', 120.00, 6),
('2025-10-28', 'Entregue', 78.00, 6),
('2025-10-30', 'Confirmado', 165.00, 7);

-- Inserir ITENS_PEDIDO
-- Pedido 1 (Maria Silva - 15/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(1, 5, 3, 18.00),  -- Goiabada Cascão
(1, 9, 1, 50.00);  -- Mel Orgânico

-- Pedido 2 (Maria Silva - 20/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(2, 6, 3, 15.00),  -- Geleia de Morango
(2, 11, 2, 20.00); -- Doce de Abóbora

-- Pedido 3 (Maria Silva - 01/11)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(3, 1, 2, 25.00),  -- Doce de Leite Tradicional
(3, 2, 1, 45.00);  -- Queijo Minas Artesanal

-- Pedido 4 (João Santos - 25/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(4, 1, 3, 25.00),  -- Doce de Leite Tradicional
(4, 2, 1, 45.00),  -- Queijo Minas Artesanal
(4, 9, 1, 30.00);  -- Mel Orgânico (preço promocional)

-- Pedido 5 (João Santos - 28/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(5, 1, 2, 25.00),  -- Doce de Leite Tradicional
(5, 4, 2, 35.00),  -- Linguiça Artesanal
(5, 5, 1, 15.00);  -- Goiabada (preço promocional)

-- Pedido 6 (Ana Paula - 22/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(6, 9, 1, 50.00),  -- Mel Orgânico
(6, 6, 3, 15.00);  -- Geleia de Morango

-- Pedido 7 (Ana Paula - 30/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(7, 5, 2, 18.00),  -- Goiabada Cascão
(7, 14, 5, 10.00), -- Rapadura
(7, 10, 1, 3.00);  -- Própolis (preço promocional)

-- Pedido 8 (Carlos - 01/11)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(8, 2, 3, 45.00),  -- Queijo Minas Artesanal
(8, 1, 2, 25.00),  -- Doce de Leite Tradicional
(8, 9, 1, 50.00);  -- Mel Orgânico

-- Pedido 9 (Fernanda - 01/11)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(9, 1, 3, 25.00),  -- Doce de Leite Tradicional
(9, 16, 1, 60.00), -- Cachaça Artesanal
(9, 5, 3, 15.00);  -- Goiabada (preço promocional)

-- Pedido 10 (Pedro - 18/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(10, 2, 2, 45.00), -- Queijo Minas Artesanal
(10, 6, 2, 15.00); -- Geleia de Morango

-- Pedido 11 (Pedro - 28/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(11, 5, 2, 18.00), -- Goiabada Cascão
(11, 11, 2, 20.00),-- Doce de Abóbora
(11, 14, 2, 1.00); -- Rapadura (preço promocional)

-- Pedido 12 (Juliana - 30/10)
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preço) VALUES
(12, 1, 4, 25.00), -- Doce de Leite Tradicional
(12, 9, 1, 50.00), -- Mel Orgânico
(12, 6, 1, 15.00); -- Geleia de Morango

-- Inserir LOGISTICA
INSERT INTO LOGISTICA (data, status, observação, id_pedido) VALUES
-- Pedidos já entregues
('2025-10-16', 'Entregue', 'Entrega realizada com sucesso', 1),
('2025-10-21', 'Entregue', 'Cliente recebeu em mãos', 2),
('2025-11-02', 'Entregue', 'Entregue ao porteiro', 3),
('2025-10-26', 'Entregue', 'Assinado pelo cliente', 4),
-- Pedidos em processo
('2025-10-29', 'Em Trânsito', 'Transportadora: Logística Express - Previsão: 05/11/2025', 5),
('2025-10-23', 'Entregue', 'Entrega sem problemas', 6),
('2025-10-31', 'Aguardando Coleta', 'Aguardando coleta pela transportadora', 7),
('2025-11-01', 'Saiu para Entrega', 'Entrega prevista para hoje até 18h', 8),
('2025-11-02', 'Em Trânsito', 'Transportadora: Rápido Entrega - Previsão: 04/11/2025', 9),
('2025-10-19', 'Entregue', 'Entrega no prazo', 10),
('2025-10-29', 'Entregue', 'Cliente satisfeito', 11),
('2025-10-31', 'Em Separação', 'Produtos sendo separados no estoque', 12);

-- ============================================================================
-- FIM DO SCRIPT DE INSERÇÃO
-- ============================================================================

