-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Cliente (
id_cliente SERIAL PRIMARY KEY,
celular_cliente varchar(15),
nome_cliente varchar(100),
cpf_cliente varchar(14)
)

CREATE TABLE Produto (
valor_produto decimal(10,2),
qtde_produto int,
id_produto serial PRIMARY KEY
)

CREATE TABLE compra (
id_pedido serial PRIMARY KEY,
data_compra_produto date,
id_produto INT,
id_cliente INT,
FOREIGN KEY(id_produto) REFERENCES Produto (id_produto)
FOREIGN KEY(id_cliente) REFERENCES Cliente (id_cliente)
/*falha: chave estrangeira*/
)

