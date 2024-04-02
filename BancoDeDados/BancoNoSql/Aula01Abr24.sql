-- CRIANDO O BANCO DE DADOS
CREATE DATABASE EXERCICIO_01ABR;

-- CRIANDO A TABELA FORNECEDOR
CREATE TABLE Fornecedor(
    Fcodigo INT NOT NULL PRIMARY KEY,
    Fnome VARCHAR(30) NOT NULL,
    Status INT,
    Cidade VARCHAR (30)
);
SELECT * FROM Fornecedor;
DROP TABLE Fornecedor;

-- CRIANDO TABELA DE PEÇA
CREATE TABLE Peca(
    Pcodigo INT NOT NULL PRIMARY KEY,
    Pnome VARCHAR(30) NOT NULL,
    Cor VARCHAR (30) NOT NULL,
    Peso DECIMAL(10,3) NOT NULL,
    Cidade VARCHAR(15) NOT NULL
);
SELECT * FROM Peca;
DROP TABLE Peca;

CREATE TABLE Instituicao(
    Icodigo INT NOT NULL PRIMARY KEY,
    Inome VARCHAR(30) NOT NULL
);
SELECT * FROM Instituicao;

DROP TABLE istituicao;

CREATE TABLE Projeto(
    PRcodigo INT NOT NULL PRIMARY KEY,
    PRnome VARCHAR(30) NOT NULL,
    Cidade VARCHAR(15) NOT NULL,
    Icodigo INT NOT NULL,
    FOREIGN KEY (Icodigo) REFERENCES instituicao
);
SELECT * FROM Projeto;
DROP TABLE Projeto;

CREATE TABLE Fornecimento(
    Fcodigo INT NOT NULL,
    FOREIGN KEY (Fcodigo) REFERENCES Fornecedor,
    Pcodigo INT NOT NULL,
    FOREIGN KEY (Pcodigo) REFERENCES Peca,
    PRcodigo INT NOT NULL,
    FOREIGN KEY (PRcodigo) REFERENCES Projeto,
    Quantidade INT NOT NULL
);
SELECT * FROM Fornecimento;

-- EXERCICIO 2 - ALTER TABLE

-- CRIAR UMA NOVA TABELA CHAMA "CIDADE" SUBSTITUINDO A TABELA "INSTITUIÇÃO"
CREATE TABLE Cidade(
    Ccod INT NOT NULL PRIMARY KEY,
    Cnome VARCHAR(30) NOT NULL,
    uf VARCHAR(2) NOT NULL
);
SELECT * FROM Cidade;

ALTER TABLE Fornecedor ADD fone INT, DROP Cidade, ADD Ccod INT;

ALTER TABLE Fornecedor ADD FOREIGN KEY (Ccod) REFERENCES Cidade;

ALTER TABLE Peca DROP Cidade, ADD Ccod INT;

ALTER TABLE Peca ADD FOREIGN KEY (Ccod) REFERENCES Cidade;

ALTER TABLE Projeto DROP Cidade, ADD Ccod INT;

ALTER TABLE Projeto ADD FOREIGN KEY (Ccod) REFERENCES Cidade;

ALTER TABLE Projeto DROP Icodigo;

ALTER TABLE Fornecedor ALTER COLUMN Status SET DEFAULT 'ATIVO';

-- EXERCICIO 3 - INSERIR/ DELETAR/ UPDATE
INSERT INTO Fornecedor (fcodigo, fnome, fone) VALUES (1, 'lebron', 40028922);
SELECT * FROM Fornecedor;
INSERT INTO Fornecedor (fcodigo, fnome, fone) VALUES (2, 'Kaluga', 1930234066);
INSERT INTO Fornecedor (fcodigo, fnome, status, fone) VALUES (3, 'LLC Logistica','INATIVO', 1130245578);
INSERT INTO Fornecedor (fcodigo, fnome, fone) VALUES (4, 'Velho Barreiro', 1930324068);
INSERT INTO Fornecedor (fcodigo, fnome, fone) VALUES (5, 'Hyundai', 1930224545);
