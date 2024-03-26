CREATE DATABASE AULA_SQL;

DROP DATABASE AULA_SQL;

CREATE DATABASE DB_AULA25MAR24;

\C DATABASE DB_AULA25MAR24;

CREATE TABLE Fornecedor(
    Fcodigo INT NOT NULL,
    Fnome VARCHAR(30) NOT NULL,
    Status INT,
    Cidade VARCHAR (30)
);

-- selecionar dados da tabela
SELECT * FROM Fornecedor;

-- cria a tabela se ela não existir
-- e se ela existir não acontece nada inclusive erro
CREATE TABLE IF NOT EXISTS Fornecedor(
    Fcodigo INT NOT NULL, -- "not null" quer dizer que o campo não pode estar vazio
    Fnome VARCHAR(30) NOT NULL, -- "not null" quer dizer que o campo não pode estar vazio
    Status INT,
    Cidade VARCHAR (30)
);

CREATE TABLE Departamento(
    Dcodigo INT NOT NULL,
    Dnome VARCHAR(30) NOT NULL,
    Cidade VARCHAR(30),
    PRIMARY KEY (Dcodigo)
);

SELECT * FROM Departamento;

CREATE TABLE Empregado(
    Ecodigo INT NOT NULL,
    Enome VARCHAR(40) NOT NULL,
    CPF VARCHAR(15) NOT NULL,
    Salario DECIMAL (7,2),
    Dcodigo INT NOT NULL,
    PRIMARY KEY (Ecodigo, Enome)
);

SELECT * FROM Empregado;

-- apaga tabela
DROP TABLE Empregado;

CREATE TABLE Empregado(
    Ecodigo INT NOT NULL,
    Enome VARCHAR(40) NOT NULL,
    CPF VARCHAR(15) NOT NULL,
    Salario DECIMAL (7,2),
    Dcodigo INT NOT NULL,
    PRIMARY KEY (Ecodigo, Enome),
    FOREIGN KEY (Dcodigo) REFERENCES Departamento
);

SELECT * FROM Empregado;

-- alterar tabelas com o Alter table

-- adicionar coluna
ALTER TABLE Empregado ADD sexo CHAR(1);

-- remover coluna
ALTER TABLE Empregado DROP sexo;

-- exibir
SELECT * FROM Empregado;

-- renomear tabela
ALTER TABLE Empregado RENAME TO Funcionario;

-- ALTER TABLE tabela ALTER COLUMN campo nome tipo_dado;
ALTER TABLE Fornecedor ALTER COLUMN status TYPE INT ativo TYPE BOOLEAN;
