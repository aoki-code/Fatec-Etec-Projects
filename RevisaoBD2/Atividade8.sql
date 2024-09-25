CREATE DATABASE Atividade8
USE Atividade8

CREATE TABLE cliente (
codigo                INT                       NOT NULL,
nome                  VARCHAR(30)               NOT NULL,
endereco              VARCHAR(40)               NOT NULL,
telefone              VARCHAR(8)                NOT NULL,
telefone_comercial    VARCHAR(8)                NULL
PRIMARY KEY(codigo)
)

CREATE TABLE tipomercadorias (
codigo                INT                       NOT NULL,
nome                  VARCHAR(20)               NOT NULL  
PRIMARY KEY(codigo)      
)

CREATE TABLE corredor (
codigo                      INT                       NOT NULL,
nome                        VARCHAR(30)               NULL,
tipomercadorias_codigo      INT                       NULL
PRIMARY KEY(codigo)
FOREIGN KEY(tipomercadorias_codigo)  REFERENCES  tipomercadorias(codigo)
)

CREATE TABLE mercadoria (
codigo                      INT                       NOT NULL,
nome                        VARCHAR(30)               NOT NULL,
corredor_codigo             INT                       NOT NULL,
tipomercadorias_codigo      INT                       NOT NULL,
valor                       DECIMAL(7, 2)             NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (corredor_codigo)          REFERENCES corredor(codigo),
FOREIGN KEY (tipomercadorias_codigo)   REFERENCES tipomercadorias(codigo)
)

CREATE TABLE compra (
nota_fiscal                 INT                       NOT NULL,
codigo_cliente              INT                       NOT NULL,
valor                       DECIMAL(7, 2)             NOT NULL
PRIMARY KEY (nota_fiscal)
FOREIGN KEY (codigo_cliente)    REFERENCES cliente(codigo)
)

INSERT INTO cliente VALUES 
(1, 'Luis Paulo', 'R. Xv de Novembro, 100', '45657878', NULL),
(2, 'Maria Fernanda', 'R. Anhaia, 1098', '27289098', '40040090'),
(3, 'Ana Claudia', 'Av. Voluntários da Pátria, 876', '21346548', NULL),
(4, 'Marcos Henrique', 'R. Pantojo, 76', '51425890', '30394540'),
(5, 'Emerson Souza', 'R. Pedro Álvares Cabral, 97', '44236545', '39389900'),
(6, 'Ricardo Santos', 'Trav. Hum, 10', '98789878', NULL)

INSERT INTO tipomercadorias (codigo, nome)
VALUES (10001, 'Pães')

INSERT INTO tipomercadorias (codigo, nome)
VALUES (10002, 'Frios')

INSERT INTO tipomercadorias (codigo, nome)
VALUES (10003, 'Bolacha')

INSERT INTO tipomercadorias (codigo, nome)
VALUES (10004, 'Clorados')

INSERT INTO tipomercadorias (codigo, nome)
VALUES (10005, 'Frutas')

INSERT INTO tipomercadorias (codigo, nome)
VALUES (10006, 'Esponjas')

INSERT INTO tipomercadorias (codigo, nome)
VALUES (10007, 'Massas')

INSERT INTO tipomercadorias (codigo, nome)
VALUES (10008, 'Molhos')

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES (101, 10001, 'Padaria')

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES (102, 10002, 'Calçados')

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES (103, 10003, 'Biscoitos')

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES (104, 10004, 'Limpeza')

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES (105, NULL, NULL)

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES (106, NULL, NULL)

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES (107, 10007, 'Congelados')

INSERT INTO mercadoria VALUES
(1001, 'Pão de Forma', 101, 10001, 3.5),
(1002, 'Presunto', 101, 10002, 2.0),
(1003, 'Cream Cracker', 103, 10003, 4.5),
(1004, 'Água Sanitária', 104, 10004, 6.5),
(1005, 'Maçã', 105, 10005, 0.9),
(1006, 'Palha de Aço', 106, 10006, 1.3),
(1007, 'Lasanha', 107, 10007, 9.7)

INSERT INTO compra (nota_fiscal, codigo_cliente, valor)
VALUES             (1234, 2, 200)
GO

INSERT INTO compra (nota_fiscal, codigo_cliente, valor)
VALUES (2345, 4, 156)

INSERT INTO compra (nota_fiscal, codigo_cliente, valor)
VALUES (3456, 6, 354)

INSERT INTO compra (nota_fiscal, codigo_cliente, valor)
VALUES (4567, 3, 19)

--Valor da Compra de Luis Paulo
SELECT  valor
FROM compra
WHERE codigo_cliente IN (
    SELECT codigo
	FROM cliente
	WHERE nome = 'Luis Paulo'
	)

--Valor da Compra de Marcos Henrique
SELECT  valor
FROM compra
WHERE codigo_cliente IN (
    SELECT codigo
	FROM cliente
	WHERE nome = 'Marcos Henrique'
	)

--Endereço e telefone do comprador de Nota Fiscal = 4567
SELECT endereco, telefone
FROM cliente
WHERE codigo IN (
    SELECT codigo_cliente
	FROM compra
	WHERE nota_fiscal = 4567
	)

--Valor da mercadoria cadastrada do tipo " Pães"
SELECT distinct m.valor
FROM mercadoria m, tipomercadorias tm
WHERE m.tipomercadorias_codigo = tm.codigo
      AND tm.nome = 'Pães'

--Nome do corredor onde está a Lasanha
SELECT co.nome
FROM corredor co, tipomercadorias tm, mercadoria m
WHERE co.codigo = m.corredor_codigo
      AND m.tipomercadorias_codigo = tm.codigo
	  AND m.nome = 'Lasanha'

--Nome do corredor onde estão os clorados
SELECT co.nome
FROM corredor co, tipomercadorias tm, mercadoria m
WHERE co.codigo = m.corredor_codigo
      AND m.tipomercadorias_codigo = tm.codigo
	  AND tm.nome = 'Clorados'