CREATE DATABASE Atividade4
USE Atividade4

CREATE TABLE cliente (
CPF			CHAR(12)		NOT NULL,
nome		VARCHAR(150)	NOT NULL,
telefone	CHAR(8)			NOT NULL
PRIMARY KEY(CPF)
)

CREATE TABLE fornecedor (
id			INT				NOT NULL,
nome		VARCHAR(150)	NOT NULL,
logradouro	VARCHAR(200)	NOT NULL,
num			INT				NOT NULL,
complemento	VARCHAR(60)		NOT NULL,
cidade		VARCHAR(50)		NOT NULL
PRIMARY KEY(id)
)

CREATE TABLE produto (
codigo		INT				NOT NULL,
descricao	VARCHAR(255)	NOT NULL,
fornecedor	INT				NOT NULL,
preco		DECIMAL(7,2)	NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(fornecedor)
	REFERENCES fornecedor(id)
)

CREATE TABLE venda (
codigo		INT				NOT NULL,
produto		INT				NOT NULL,
cliente		CHAR(12)		NOT NULL,
quantidade	INT				NOT NULL,
valor_total	DECIMAL(7,2)	NOT NULL,
data		DATETIME		NOT NULL
PRIMARY KEY(codigo, produto, cliente)
FOREIGN KEY(produto)
	REFERENCES produto(codigo),
FOREIGN KEY(cliente)
	REFERENCES cliente(CPF)
)

INSERT INTO cliente VALUES ('34578909290', 'Julio Cesar', '82736541'),
('25186533710', 'Maria Antonia', '87652314'),
('87627315416',	'Luiz Carlos', '61289012'),
('79182639800', 'Paulo Cesar', '90765273')

INSERT INTO fornecedor VALUES (1, 'LG',	'Rod. Bandeirantes', 70000,	'Km 70', 'Itapeva'),
(2,	'Asus',	'Av. Nações Unidas', 10206,	'Sala 225',	'São Paulo'),
(3,	'AMD',	'Av. Nações Unidas', 10206,	'Sala 1095', 'São Paulo'),
(4,	'Leadership', 'Av. Nações Unidas', 10206, 'Sala 87', 'São Paulo'),
(5,	'Inno',	'Av. Nações Unidas', 10206,	'Sala 34', 'São Paulo')

INSERT INTO produto VALUES (1, 'Monitor 19 pol.', 1, 449.99),
(2,	'Netbook 1GB Ram 4 Gb HD',	2, 699.99),
(3,	'Gravador de DVD - Sata', 1, 99.99),
(4,	'Leitor de CD',	1, 49.99),
(5,	'Processador - Phenom X3 - 2.1GHz',	3, 349.99),
(6,	'Mouse', 4,	19.99),
(7,	'Teclado', 4, 25.99),
(8,	'Placa de Video - Nvidia 9800 GTX - 256MB/256 bits', 5,	599.99)

INSERT INTO venda VALUES (1, 1, '25186533710', 1,	449.99,	'03/09/2009'),
(1, 4, '25186533710', 1, 49.99, '03/09/2009'),
(1, 5, '25186533710', 1, 349.99, '03/09/2009'),
(2,	6, '79182639800', 4, 79.96, '06/09/2009'),
(3, 8, '87627315416', 1, 599.99, '06/09/2009'),
(3,	3, '87627315416', 1, 99.99, '06/09/2009'),
(3,	7, '87627315416', 1, 25.99,	'06/09/2009'),
(4,	2, '34578909290', 2, 1399.98, '08/09/2009')

--Consultar no formato dd/mm/aaaa:
--Data da Venda 4
SELECT CONVERT(VARCHAR(10), data, 103) AS data_venda
FROM venda
WHERE codigo = 4

--Inserir na tabela Fornecedor, a coluna Telefone
--e os seguintes dados:
ALTER TABLE fornecedor
ADD telefone	CHAR(8)

--1 (7216-5371)
UPDATE fornecedor
SET telefone = '72165371'
WHERE id = 1

--2 (8715-3738)
UPDATE fornecedor
SET telefone = '87153738'
WHERE id = 2

--4 (3654-6289)
UPDATE fornecedor
SET telefone = '36546289'
WHERE id = 4

--Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone dos fornecedores
SELECT nome, logradouro + ', ' + CAST(num AS VARCHAR) + ', ' + complemento + ', ' + cidade AS endereco_completo, telefone
FROM fornecedor
ORDER BY nome ASC

--Produto, quantidade e valor total do comprado por Julio Cesar
SELECT pr.descricao, v.quantidade, v.valor_total
FROM produto pr, cliente c, venda v
WHERE pr.codigo = v.produto
	AND c.CPF = v.cliente
	AND c.nome LIKE '%Julio%'

--Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar
SELECT CONVERT(VARCHAR(10), v.data, 103) AS data_venda, v.valor_total
FROM venda v, cliente c
WHERE v.cliente = c.CPF
	AND c.nome LIKE '%Paulo%'

--Consultar, em ordem decrescente, o nome e o preço de todos os produtos 
SELECT descricao, preco
FROM produto
ORDER BY descricao DESC, preco DESC