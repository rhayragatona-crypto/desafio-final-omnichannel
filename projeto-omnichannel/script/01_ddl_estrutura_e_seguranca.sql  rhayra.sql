-- =====================================================================
-- 1. CRIAÇÃO DO SCHEMA (DDL)
-- =====================================================================
CREATE DATABASE IF NOT EXISTS omnichannel_db 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

USE omnichannel_db;

-- =====================================================================
-- 2. CRIAÇÃO DAS TABELAS E RESTRIÇÕES (DDL)
-- =====================================================================

-- Tabela de Produtos
CREATE TABLE IF NOT EXISTS produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque_atual INT NOT NULL DEFAULT 0,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Pedidos (Omnichannel - ex: origem pode ser 'App', 'Site', 'Loja Fisica')
CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    canal_origem VARCHAR(50) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status_pedido VARCHAR(30) DEFAULT 'Pendente',
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) 
        REFERENCES clientes(id_cliente) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

-- Tabela de Itens do Pedido
CREATE TABLE IF NOT EXISTS itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) 
        REFERENCES pedidos(id_pedido) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) 
        REFERENCES produtos(id_produto) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

-- =====================================================================
-- 3. CONTROLE DE ACESSO E SEGURANÇA (DCL)
-- =====================================================================

-- 3.1. Usuário Atendente (Apenas consultas de produtos e registro básico)
CREATE USER IF NOT EXISTS 'atendente_omni'@'localhost' IDENTIFIED BY 'SenhaAtendente123!';
GRANT SELECT ON omnichannel_db.produtos TO 'atendente_omni'@'localhost';
GRANT SELECT, INSERT ON omnichannel_db.clientes TO 'atendente_omni'@'localhost';
GRANT SELECT, INSERT ON omnichannel_db.pedidos TO 'atendente_omni'@'localhost';

-- 3.2. Usuário Gerente / Administrador Operacional (Acesso total ao banco do sistema)
CREATE USER IF NOT EXISTS 'gerente_omni'@'localhost' IDENTIFIED BY 'SenhaGerente123!';
GRANT ALL PRIVILEGES ON omnichannel_db.* TO 'gerente_omni'@'localhost';

-- Aplicar as alterações de privilégios imediatamente
FLUSH PRIVILEGES;