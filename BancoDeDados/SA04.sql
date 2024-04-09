-- EXERCICIO 1
 -- DDL(Data Definition Language)

CREATE DATABASE DB_SA04_EX1;

-- 1 - criação da tabela clientes

CREATE TABLE Clientes(ID SERIAL PRIMARY KEY,
                                        Nome VARCHAR(30) NOT NULL,
                                                         Sobrenome VARCHAR(30) NOT NULL,
                                                                               Email VARCHAR(30));

-- mostrar tabela

SELECT *
FROM Clientes;

-- 2 - alterar email para unico, assim não pode se repetir

ALTER TABLE Clientes ADD CONSTRAINT Email UNIQUE (Email);

-- 3 - criar tabela pedido

CREATE TABLE Pedidos(ID SERIAL PRIMARY KEY,
                                       ID_Clientes INT NOT NULL, -- 4 - referenciar ID da tabela clientes

                     FOREIGN KEY (ID_Clientes) REFERENCES Clientes (ID),
                                                          DATA_PEDIDO DATE, TOTAL DECIMAL(10,2));

-- 5 - modificando a tabela adicionando coluna status limitando as informações que serão informadas

ALTER TABLE Pedidos ADD COLUMN STATUS VARCHAR(20) CHECK (STATUS IN ('EM ANDAMENTO',
                                                                    'FINALIZADO',
                                                                    'CANCELADO'));

-- DML (Data Manipulation Language)
-- 1. inserir dados de três clientes

INSERT INTO Clientes (Nome, Sobrenome, Email)
VALUES ('Lebron',
        'James',
        'kingjames@gmail.com');


INSERT INTO Clientes (Nome, Sobrenome, Email)
VALUES ('Stephan',
        'Curry',
        'splashcurry@gmail.com');


INSERT INTO Clientes (Nome, Sobrenome, Email)
VALUES ('Kyrie',
        'Irving',
        'uncledrew@gmail.com');

-- 2. inserir dados de pedidos dos clientes

INSERT INTO Pedidos (ID_Clientes, DATA_PEDIDO, TOTAL, STATUS)
VALUES ('1',
        '2023-04-04',
        53.00,
        'EM ANDAMENTO');


INSERT INTO Pedidos (ID_Clientes, DATA_PEDIDO, TOTAL, STATUS)
VALUES ('2',
        '2023-02-06',
        84.00,
        'FINALIZADO');


INSERT INTO Pedidos (ID_Clientes, DATA_PEDIDO, TOTAL, STATUS)
VALUES ('1',
        '2023-03-30',
        33.00,
        'CANCELADO');


INSERT INTO Pedidos (ID_Clientes, DATA_PEDIDO, TOTAL, STATUS)
VALUES ('3',
        '2023-04-01',
        150.00,
        'EM ANDAMENTO');


INSERT INTO Pedidos (ID_Clientes, DATA_PEDIDO, TOTAL, STATUS)
VALUES ('2',
        '2023-03-15',
        65.00,
        'FINALIZADO');

-- visualizar tabela

SELECT *
FROM Pedidos;

-- 3. atualizar um valor da tabela

UPDATE Pedidos
SET TOTAL = 100.00
WHERE ID = '4';

-- 4. excluir um cliente e seus registro da tabela pedidos
-- deletar primeiro as informações da tabela pedidos pois o ID esta sendo referenciado, então caso você tente excluir primeiro o ID na tabela clientes vai dar erro

DELETE
FROM Pedidos
WHERE ID_Clientes = 3;


DELETE
FROM Clientes
WHERE ID = 3;

-- 5. selecionar apenas pedidos com status em andamento utilizando select

SELECT *
FROM Pedidos
WHERE Status = 'EM ANDAMENTO';

-- 6. Listar nome, data e total do pedido dos ultimos 30 dias

SELECT c.Nome AS Nome_Cliente,
       p.Data_Pedido,
       p.Total
FROM Pedidos p
JOIN Clientes c ON p.ID_Clientes = c.ID
WHERE p.Data_Pedido >= CURRENT_DATE - INTERVAL '30 days';

-- EXERCICIO 2
-- DDL (Data Definition Language) Exercícios:

CREATE DATABASE DB_SA04_EX2;

-- 1. criando a tabela Produtos
CREATE TABLE Produtos(ID SERIAL PRIMARY KEY,
                        Nome VARCHAR(30) NOT NULL,
                         Descricao VARCHAR(30) NOT NULL,
                          Preco DECIMAL(10,2));

-- 2. adicionar restrição na tabela para preço para o valor nao ficar negativo
ALTER TABLE Produtos
ADD CONSTRAINT CHK_Preco_Positive CHECK (Preco >= 0);

-- 3. criar tabela Pedidos
CREATE TABLE Pedidos(ID SERIAL PRIMARY KEY,
                        DATA_PEDIDO DATE NOT NULL,
                        Valor DECIMAL(10,2),
                        Status VARCHAR(30)
                        );
                          
    

