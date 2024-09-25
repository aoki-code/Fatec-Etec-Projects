CREATE DATABASE atlbd
GO
USE atlbd
GO
CREATE TABLE funcionario (
cod			INT				NOT NULL,
nome		VARCHAR(100)	NOT NULL,
salario		DECIMAL(7,2)	NOT NULL
PRIMARY KEY (cod)
)

INSERT INTO funcionario VALUES
(1, 'Fulano', 500.50),
(2, 'Beltrano', 812.72),
(3, 'Cicrano', 1203.10)


CREATE TABLE dependente (
cod_func		INT				NOT NULL,
nome_depen		VARCHAR(100)	NOT NULL,
salario_depen	DECIMAL(7,2)	NOT NULL
PRIMARY KEY (cod_func)
FOREIGN KEY (cod_func) REFERENCES funcionario(cod)
)

INSERT INTO dependente VALUES
(1, 'Tijolinho', 309.60),
(2, 'Mario', 140.44),
(3, 'Luigi', 249.99)

SELECT * FROM dependente
SELECT * FROM funcionario

CREATE FUNCTION fn_tablefunc()
RETURNS @tabela TABLE (
nome_func		VARCHAR(100),
salario_func		DECIMAL(7,2),
nome_depen		VARCHAR(100),
salario_depen	DECIMAL(7,2)
)
AS
BEGIN
	INSERT INTO @tabela(nome_func, nome_depen, salario_func, salario_depen) 
		SELECT f.nome, d.nome_depen, f.salario, d.salario_depen
			FROM funcionario f INNER JOIN dependente d ON f.cod = d.cod_func
		RETURN
	END

SELECT * FROM fn_tablefunc()

CREATE FUNCTION fn_tablecont()
RETURNS @tabela TABLE(
salario_func	DECIMAL(7,2),
salario_depen	DECIMAL(7,2)
)
AS
BEGIN
	INSERT INTO @tabela(salario_func, salario_depen) 
		SELECT f.salario, d.salario_depen
			FROM funcionario f INNER JOIN dependente d ON f.cod = d.cod_func
		RETURN
	END

CREATE FUNCTION fn_cont(@cod INT)
RETURNS DECIMAL(7,1)
AS
BEGIN
	DECLARE @total		DECIMAL(7,2),
			@sal_func	DECIMAL(7,2),
			@sal_dep	DECIMAL(7,1)
 
	SET @sal_func = (SELECT f.salario FROM funcionario f WHERE cod = @cod)
	SET @sal_dep = (SELECT d.salario_depen FROM dependente d WHERE cod_func = @cod)
 
	SET @total = @sal_dep + @sal_func

	RETURN @total
END