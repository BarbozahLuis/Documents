-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Cliente (
CPF VARCHAR(14) Not Null PRIMARY KEY,
Endereco VARCHAR(100) NOT NULL,
Nome VARCHAR(80) NOT NULL,
Telefone VARCHAR(15) NOT NULL
)

CREATE TABLE Produto (
Id_Produto INT NOT NULL PRIMARY KEY,
Preco DECIMAL(7,2) NOT NULL,
Nome VARCHAR(50) NOT NULL,
Estoque INT NOT NULL
)

CREATE TABLE Pedido (
Num_Pedido INT NOT NULL PRIMARY KEY,
Total_pedido DECIMAL(7,2) NOT NULL,
Data_Pedido DATE NOT NULL,
CPF VARCHAR(14) Not Null,
FOREIGN KEY(CPF) REFERENCES Cliente (CPF)
)

CREATE TABLE Contem (
Quantidade int not null,
Comprovante VARCHAR(50) NOT NULL PRIMARY KEY,
Id_Produto INT NOT NULL,
Num_Pedido INT NOT NULL,
FOREIGN KEY(Id_Produto) REFERENCES Produto (Id_Produto),
FOREIGN KEY(Num_Pedido) REFERENCES Pedido (Num_Pedido)
)

