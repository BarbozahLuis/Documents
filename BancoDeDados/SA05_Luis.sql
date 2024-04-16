CREATE DATABASE DB_SA05_LUIS;

-- DDL
CREATE TABLE Clientes(
            ID SERIAL PRIMARY KEY,
            Nome VARCHAR(30) NOT NULL,
            Sobrenome VARCHAR(30) NOT NULL,
            Email VARCHAR(30) UNIQUE
);


SELECT * FROM Clientes;

CREATE TABLE Pedidos(
            ID SERIAL PRIMARY KEY,
            ID_Clientes INT NOT NULL,
            FOREIGN KEY (ID_Clientes) REFERENCES Clientes (ID),
            DATA_PEDIDO DATE NOT NULL,
            TOTAL DECIMAL(10,2)
);

SELECT * FROM Pedidos;

CREATE TABLE Produtos(
            ID SERIAL PRIMARY KEY,
            Pnome VARCHAR(30) NOT NULL,
            Descricao VARCHAR(30) NOT NULL,
            Preco NUMERIC CHECK (preco > 0)
);

SELECT * FROM Produtos;

CREATE TABLE Categorias(
            ID SERIAL PRIMARY KEY,
            Cnome VARCHAR(30) NOT NULL
);

SELECT * FROM Categorias;

CREATE TABLE Pedidos_Produtos(
    ID_Pedido INT NOT NULL,
    ID_Produto INT NOT NULL,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID)
);

SELECT * FROM Pedidos_Produtos;

CREATE TABLE Produtos_Categorias (
    ID_Produto INT NOT NULL,
    ID_Categoria INT NOT NULL,
    PRIMARY KEY (ID_Produto, ID_Categoria),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID)
);

SELECT * FROM Produtos_Categorias;

CREATE TABLE Empregados (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Sobrenome VARCHAR(50) NOT NULL,
    Cargo VARCHAR(20) NOT NULL,
    CONSTRAINT valid_cargo CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'))
);

SELECT * FROM Empregados;

CREATE TABLE Vendas (
    ID SERIAL PRIMARY KEY,
    ID_Produto INT NOT NULL,
    ID_Clientes INT NOT NULL,
    Data_Venda DATE NOT NULL,
    Quantidade INT NOT NULL,
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Clientes) REFERENCES Clientes(ID)
);

ALTER TABLE Clientes ADD Telefone VARCHAR(15);

ALTER TABLE Produtos ALTER COLUMN Descricao DROP NOT NULL;

ALTER TABLE Pedidos DROP CONSTRAINT Pedidos_ID_Clientes_fkey;

ALTER TABLE Empregados RENAME TO Funcionarios;

-- DML 
INSERT INTO Clientes (Nome, Sobrenome, Email) VALUES
('Lebron', 'James', 'lebron23james@gmail.com'),
('Kobe', 'Bryant', 'kobe24bryant@gmail.com'),
('Michael', 'Jordan', 'michael23jordan@gmail.com'),
('Stephan', 'Curry', 'stephan30curry@gmail.com'),
('Kyrie', 'Irving', 'kyrie11irving');

INSERT INTO Pedidos (ID_Clientes, DATA_PEDIDO, TOTAL)
VALUES ('1','2024-04-04', 53.00),
 ('3','2024-02-10', 90.00),
 ('4','2024-04-30', 150.50),
 ('5','2024-04-20', 300.65),
 ('2','2024-03-13', 299.99),
 ('2','2024-01-15', 40.00),
 ('4','2024-02-04', 35.99),
 ('5','2024-03-29', 459.88),
 ('1','2024-04-12', 70.50),
 ('3','2024-03-25', 20.60);

INSERT INTO Produtos (Pnome, descricao, Preco)
VALUES ('Bola wilson','basquete', 150.00),
 ('Bola penalti','Futebol', 90.00),
 ('Tenis nike Lebron','Lebron 15', 700.0),
 ('Chuteira nike CR7','total 90', 500.00),
 ('camiseta basquete','houston 13', 299.99),
 ('camiseta basquete','lakers 23', 40.00),
 ('camiseta basquete','lakers 24', 35.99),
 ('camiseta futebol','real madrid 10', 459.88),
 ('camiseta futebol','barcelona 10', 70.50),
 ('camiseta futebol','real madrid 7', 20.60),
 ('blusa futebol','liverpool treino', 20.60),
 ('blusa futebol','barcelona treino', 20.60),
 ('calça futebol','barcelona treino', 20.60),
 ('camiseta futebol','brasil torcedor', 20.60),
 ('shorts futebol','brasil torcedor', 20.60);

INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto)
VALUES ('1', '1'),
('1', '10'),
('3', '7');

INSERT INTO Categorias (Cnome)
VALUES ('Tenis'),
('Roupas'),
('Acessório');

INSERT INTO Produtos_Categorias (ID_Produto, ID_Categoria)
VALUES ('1', '3'),
('5', '2'),
('3', '1');

INSERT INTO Funcionarios (Nome, Sobrenome, Cargo) VALUES
('Paul', 'George', 'Atendente'),
('Trae', 'Young', 'Atendente'),
('Luka', 'Doncic', 'Gerente'),
('Nikola', 'Jovic', 'Vendedor'),
('Demar', 'DeRozan', 'Vendedor');

INSERT INTO Vendas (ID_Produto, ID_Clientes, Data_Venda, Quantidade) VALUES
('10', '3', '2024-04-10', '5'),
('5', '4', '2024-03-30','2'),
('3', '1', '2024-04-5','1'),
('12', '2', '2024-01-30','3'),
('7', '5', '2024-02-29','4');

UPDATE Produtos SET Preco = 60.00 WHERE ID = 10;

UPDATE Funcionarios SET Cargo = 'Atendente' WHERE ID = 3;


DELETE FROM Vendas WHERE ID_Clientes = 3;
DELETE FROM Pedidos WHERE ID_Clientes = 3;
DELETE FROM Clientes WHERE ID = 3;

DELETE FROM Produtos WHERE ID = 4;
DELETE FROM Pedidos_Produtos WHERE ID_Produto = 4;

DELETE FROM Funcionarios WHERE ID = 5;

ALTER TABLE Pedidos ADD COLUMN STATUS VARCHAR(20) CHECK (STATUS IN ('EM ANDAMENTO', 'FINALIZADO', 'CANCELADO'));

UPDATE Pedidos SET Status = 'EM ANDAMENTO' WHERE ID = 8;

SELECT * FROM Pedidos WHERE STATUS 'EM ANDAMENTO';













