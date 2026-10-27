-- Recriar as tabelas com a estrutura exata esperada pelo DML
DROP TABLE IF EXISTS itens_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque_atual INT NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE
);

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATETIME,
    valor_total DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- =====================================================================
-- Script DML Corrigido (Sem forçar colunas de ID manuais)
-- =====================================================================

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Tabela: categorias
INSERT INTO categorias (nome, descricao) VALUES
('Eletrônicos', 'Dispositivos eletrônicos e gadgets em geral'),
('Informática', 'Computadores, notebooks e acessórios de rede'),
('Áudio', 'Fones de ouvido, caixas de som e equipamentos de som'),
('Eletrodomésticos', 'Aparelhos para uso doméstico e cozinha'),
('Smartphones', 'Celulares, smartphones e acessórios móveis');

-- 2. Tabela: produtos
INSERT INTO produtos (nome, preco, estoque_atual, categoria_id) VALUES
('Smartphone Galaxy S23', 4500.00, 15, 5),
('Notebook Dell Inspiron', 3800.00, 8, 2),
('Fone de Ouvido Bluetooth', 250.00, 30, 3),
('Smart TV 50 Polegadas 4K', 2900.00, 5, 1),
('Cafeteira Elétrica Express', 350.00, 12, 4);

-- 3. Tabela: clientes
INSERT INTO clientes (nome, email, telefone, data_cadastro) VALUES
('Ana Clara Souza', 'ana.souza@email.com', '(11) 98765-4321', '2026-01-15'),
('Carlos Eduardo Lima', 'carlos.lima@email.com', '(21) 97123-4567', '2026-02-02'),
('Mariana Oliveira', 'mariana.oliveira@email.com', '(31) 99888-1234', '2026-02-10'),
('Lucas Gabriel Santos', 'lucas.santos@email.com', '(41) 99111-2233', '2026-03-01'),
('Beatriz Martins', 'beatriz.martins@email.com', '(51) 98333-4455', '2026-03-12');

-- 4. Tabela: pedidos
INSERT INTO pedidos (cliente_id, data_pedido, valor_total, status) VALUES
(1, '2026-03-20 14:30:00', 4750.00, 'Concluído'),
(2, '2026-03-22 10:15:00', 3800.00, 'Processando'),
(3, '2026-03-23 16:45:00', 2900.00, 'Pendente'),
(4, '2026-03-25 09:00:00', 350.00, 'Concluído'),
(5, '2026-03-26 18:20:00', 250.00, 'Cancelado');

-- 5. Tabela: itens_pedido
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 4500.00), 
(1, 3, 1, 250.00),  
(2, 2, 1, 3800.00), 
(3, 4, 1, 2900.00), 
(4, 5, 1, 350.00);  

SET FOREIGN_KEY_CHECKS = 1;
