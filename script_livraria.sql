/*
  PROJETO: Sistema de Gerenciamento de Livraria
  AUTOR: Antônio
  DESCRIÇÃO: Projeto prático de SQL. Criação de banco de dados, tabelas relacionais,
             inserção de dados e relatórios de vendas com Joins e Agregações.
*/

-- ===================================================
-- 1. CRIAÇÃO DO BANCO (DDL)
-- ===================================================
DROP DATABASE IF EXISTS LivrariaDev;
CREATE DATABASE LivrariaDev;
USE LivrariaDev;

-- Tabela de Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    cidade VARCHAR(50)
);

-- Tabela de Livros
CREATE TABLE Livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100),
    preco DECIMAL(10, 2) NOT NULL
);

-- Tabela de Vendas
CREATE TABLE Vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_livro INT,
    data_venda DATE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);

-- ===================================================
-- 2. INSERÇÃO DE DADOS (DML)
-- ===================================================
INSERT INTO Clientes (nome, email, cidade) VALUES
('Ana Silva', 'ana@email.com', 'São Paulo'),
('Carlos Souza', 'carlos@email.com', 'Rio de Janeiro'),
('Beatriz Lima', 'bia@email.com', 'Belo Horizonte');

INSERT INTO Livros (titulo, autor, preco) VALUES
('Dom Casmurro', 'Machado de Assis', 35.90),
('O Hobbit', 'J.R.R. Tolkien', 59.90),
('Clean Code', 'Robert C. Martin', 95.00),
('Algoritmos e Lógica', 'Paulo Silveira', 45.50);

INSERT INTO Vendas (id_cliente, id_livro, data_venda) VALUES
(1, 3, '2024-01-10'),
(1, 4, '2024-01-15'),
(2, 2, '2024-02-01'),
(3, 1, '2024-02-05');

-- ===================================================
-- 3. RELATÓRIOS (QUERIES)
-- ===================================================

-- Relatório A: Livros com preço acessível
SELECT * FROM Livros WHERE preco < 60.00;

-- Relatório B: Detalhe de Vendas (Quem comprou o quê?)
SELECT 
    Clientes.nome AS Cliente, 
    Livros.titulo AS Livro_Comprado,
    Livros.preco AS Valor
FROM Vendas
JOIN Clientes ON Vendas.id_cliente = Clientes.id_cliente
JOIN Livros ON Vendas.id_livro = Livros.id_livro;

-- Relatório C: Ranking de Clientes (Quem gastou mais?)
SELECT 
    Clientes.nome, 
    SUM(Livros.preco) AS Total_Gasto
FROM Vendas
JOIN Clientes ON Vendas.id_cliente = Clientes.id_cliente
JOIN Livros ON Vendas.id_livro = Livros.id_livro
GROUP BY Clientes.nome
ORDER BY Total_Gasto DESC;