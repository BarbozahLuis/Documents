CREATE TABLE IF NOT EXISTS contatos(
	id_contato SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	cel VARCHAR(255) NOT NULL,
	pizza VARCHAR(255) NOT NULL,
    cadastro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS entregas(
	id_entregas INT NOT NULL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	cel VARCHAR(255) NOT NULL,
	pizza VARCHAR(255) NOT NULL,
    cadastro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    situacao VARCHAR(30) NOT NULL CHECK (situacao IN ('Em andamento', 'Finalizado'))
);

CREATE TABLE IF NOT EXISTS pedido(
	id_pedido SERIAL PRIMARY KEY,
	id_entregas INT NOT NULL,
	id_contato INT NOT NULL,
	id_pizza INT NOT NULL,
	data_pedido DATE NOT NULL,
	CONSTRAINT fk_id_entregas FOREIGN KEY (id_entregas) REFERENCES entregaS (id_entregas),
	CONSTRAINT fk_id_pizza FOREIGN KEY (id_pizza) REFERENCES pizzas (id_pizza),
	CONSTRAINT fk_id_contato FOREIGN KEY (id_contato) REFERENCES contatos (id_contato)
);

CREATE TABLE IF NOT EXISTS pizzas(
	id_pizza SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	ingredientes TEXT NOT NULL
);


INSERT INTO contatos (nome, email, cel, pizza, cadastro) VALUES 
('João Silva', 'joao@example.com', '555-1234', 'Calabresa', CURRENT_DATE),
('Maria Santos', 'maria@example.com', '555-5678', 'Margherita', CURRENT_DATE),
('Carlos Oliveira', 'carlos@example.com', '555-9012', 'Quatro Queijos', CURRENT_DATE),
('Ana Pereira', 'ana@example.com', '555-3456', 'Portuguesa', CURRENT_DATE),
('Pedro Costa', 'pedro@example.com', '555-7890', 'Frango com Catupiry', CURRENT_DATE),
('Juliana Oliveira', 'juliana@example.com', '555-2345', 'Vegetariana', CURRENT_DATE),
('Lucas Rodrigues', 'lucas@example.com', '555-6789', 'Pepperoni', CURRENT_DATE),
('Fernanda Almeida', 'fernanda@example.com', '555-0123', 'Calabresa', CURRENT_DATE),
('Rafaela Lima', 'rafaela@example.com', '555-4567', 'Margherita', CURRENT_DATE),
('Gustavo Martins', 'gustavo@example.com', '555-8901', 'Quatro Queijos', CURRENT_DATE);

INSERT INTO entregas (id_entregas, nome, email, cel, pizza, cadastro, situacao) VALUES 
(1, 'João Silva', 'joao@example.com', '555-1234', 'Calabresa', CURRENT_DATE, 'Em andamento'),
(2, 'Maria Santos', 'maria@example.com', '555-5678', 'Margherita', CURRENT_DATE, 'Finalizado'),
(3, 'Carlos Oliveira', 'carlos@example.com', '555-9012', 'Quatro Queijos', CURRENT_DATE, 'Em andamento'),
(4, 'Ana Pereira', 'ana@example.com', '555-3456', 'Portuguesa', CURRENT_DATE, 'Em andamento'),
(5, 'Pedro Costa', 'pedro@example.com', '555-7890', 'Frango com Catupiry', CURRENT_DATE, 'Finalizado'),
(6, 'Juliana Oliveira', 'juliana@example.com', '555-2345', 'Vegetariana', CURRENT_DATE, 'Em andamento'),
(7, 'Lucas Rodrigues', 'lucas@example.com', '555-6789', 'Pepperoni', CURRENT_DATE, 'Finalizado'),
(8, 'Fernanda Almeida', 'fernanda@example.com', '555-0123', 'Calabresa', CURRENT_DATE, 'Em andamento'),
(9, 'Rafaela Lima', 'rafaela@example.com', '555-4567', 'Margherita', CURRENT_DATE, 'Finalizado'),
(10, 'Gustavo Martins', 'gustavo@example.com', '555-8901', 'Quatro Queijos', CURRENT_DATE, 'Em andamento');

INSERT INTO pizzas (nome, preco, ingredientes) VALUES 
('Calabresa', 25.00, 'Molho de tomate, queijo mussarela, calabresa, cebola, orégano'),
('Margherita', 22.00, 'Molho de tomate, queijo mussarela, tomate, manjericão, azeite, orégano'),
('Quatro Queijos', 28.00, 'Molho de tomate, queijo mussarela, queijo gorgonzola, queijo provolone, queijo parmesão, orégano'),
('Portuguesa', 27.00, 'Molho de tomate, queijo mussarela, presunto, ovos, cebola, azeitona, orégano'),
('Frango com Catupiry', 30.00, 'Molho de tomate, queijo mussarela, frango desfiado, catupiry, milho verde, orégano'),
('Vegetariana', 26.00, 'Molho de tomate, queijo mussarela, champignon, pimentão, cebola, azeitona, orégano'),
('Pepperoni', 29.00, 'Molho de tomate, queijo mussarela, pepperoni, pimentão, cebola, orégano');

INSERT INTO pedido (id_entregas, id_contato, id_pizza, data_pedido) VALUES 
(1, 1, 1, CURRENT_DATE),
(2, 2, 2, CURRENT_DATE),
(3, 3, 3, CURRENT_DATE),
(4, 4, 4, CURRENT_DATE),
(5, 5, 5, CURRENT_DATE),
(6, 6, 6, CURRENT_DATE),
(7, 7, 7, CURRENT_DATE),
(8, 8, 1, CURRENT_DATE),
(9, 9, 2, CURRENT_DATE),
(10, 10, 3, CURRENT_DATE);

-- exercicio 1
SELECT 
    pedido.id_pedido,
    contatos.nome AS nome_cliente,
    contatos.email AS email_cliente,
    contatos.cel AS celular_cliente,
    pizzas.nome AS pizza_pedida,
    pizzas.preco AS preco_pizza,
    pizzas.ingredientes AS ingredientes_pizza,
    pedido.data_pedido
FROM 
    pedido
JOIN 
    contatos ON pedido.id_contato = contatos.id_contato
JOIN 
    pizzas ON pedido.id_pizza = pizzas.id_pizza;

-- exercicio 2

SELECT 
    pedido.id_pedido,
    pizzas.nome AS nome_pizza,
    pizzas.preco AS preco_pizza,
    pizzas.ingredientes AS ingredientes_pizza
FROM 
    pedido
JOIN 
    pizzas ON pedido.id_pizza = pizzas.id_pizza;

-- exercio 3

CREATE TABLE IF NOT EXISTS funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    area_trabalho VARCHAR(255) NOT NULL
);


INSERT INTO funcionario (nome, area_trabalho) VALUES 
('Andreia Oliveira', 'Cozinha'),
('Luiz Fernandes', 'Atendimento'),
('Patrícia Santos', 'Entregas'),
('Felipe Costa', 'Cozinha'),
('Mariana Silva', 'Atendimento'),
('Roberto Almeida', 'Cozinha'),
('Camila Ribeiro', 'Entregas'),
('Rodrigo Souza', 'Cozinha'),
('Larissa Gonçalves', 'Atendimento'),
('Eduardo Martins', 'Entregas');

SELECT nome, area_trabalho FROM funcionario;

--exercicio 4
CREATE TABLE IF NOT EXISTS pedido_funcionario (
    id_pedido_funcionario SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_funcionario INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

INSERT INTO pedido_funcionario (id_pedido, id_funcionario) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

SELECT 
    pedido.id_pedido,
    entregas.situacao AS status_pedido,
    funcionario.nome AS funcionario_responsavel
FROM 
    pedido
JOIN 
    entregas ON pedido.id_entregas = entregas.id_entregas
JOIN 
    pedido_funcionario ON pedido.id_pedido = pedido_funcionario.id_pedido
JOIN 
    funcionario ON pedido_funcionario.id_funcionario = funcionario.id_funcionario;


--exercicio 5
SELECT 
    contatos.nome AS nome_cliente,
    contatos.email AS email_cliente,
    contatos.cel AS celular_cliente,
    pedido.id_pedido,
    pizzas.nome AS pizza_pedida,
    pedido.data_pedido
FROM 
    pedido
JOIN 
    contatos ON pedido.id_contato = contatos.id_contato
JOIN 
    pizzas ON pedido.id_pizza = pizzas.id_pizza;

--exercicio 6 
SELECT nome, ingredientes
FROM pizzas;

--exercicio 7

SELECT 
    pedido.id_pedido,
    pedido.id_entregas,
    entregas.situacao AS status_entrega,
    entregas.cadastro AS data_entrega
FROM 
    pedido
LEFT JOIN 
    entregas ON pedido.id_entregas = entregas.id_entregas;

--exercicio 8
CREATE TABLE SUPERVISORES(
    id_supervisor SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

ALTER TABLE funcionario
ADD COLUMN id_supervisor INT,
ADD CONSTRAINT fk_supervisor FOREIGN KEY (id_supervisor) REFERENCES SUPERVISORES(id_supervisor);

INSERT INTO supervisores (nome) VALUES 
('João Silva'),
('Maria Santos'),
('Carlos Oliveira');

INSERT INTO SUPERVISORES (NOME)
VALUES 
    ('Supervisor 1'),
    ('Supervisor 2'),
    ('Supervisor 3');

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 1
WHERE NOME = 'Andreia Oliveira';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 2
WHERE NOME = 'Luiz Fernandes';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 3
WHERE NOME = 'Patrícia Santos';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 1
WHERE NOME = 'Felipe Costa';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 2
WHERE NOME = 'Mariana Silva';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 3
WHERE NOME = 'Roberto Almeida';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 1
WHERE NOME = 'Rodrigo Souza';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 2
WHERE NOME = 'Larissa Gonçalves';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 3
WHERE NOME = 'Eduardo Martins';

UPDATE FUNCIONARIO
SET ID_SUPERVISOR = 1
WHERE NOME = 'Camila Ribeiro';

SELECT * FROM FUNCIONARIO

-- exercicio 9 
ALTER TABLE PIZZAS
ADD COLUMN TAMANHO VARCHAR(50);