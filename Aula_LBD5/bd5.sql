CREATE DATABASE querydinamica
GO
USE querydinamica
CREATE TABLE produto
(
	codigo	INT,
	nome	VARCHAR(100),
	valor	DECIMAL(7,2)
	PRIMARY KEY (codigo)
)
SELECT * FROM produto
INSERT INTO produto VALUES (1, 'caneta', 10.99);
INSERT INTO produto VALUES (2, 'lapis', 2.99);
INSERT INTO produto VALUES (3, 'borracha', 1.49);
INSERT INTO produto VALUES (4, 'cola', 10.00);
INSERT INTO produto VALUES (5, 'tesoura', 5.00);
INSERT INTO produto VALUES (6, 'granpeador', 15.00);
CREATE TABLE entrada
(
	codigo_transacao	CHAR(1) NOT NULL,
	codigo_produto		INT 	NOT NULL,
	quantidade			INT 	NOT NULL,
	valor_total			DECIMAL(7,2),
	PRIMARY KEY (codigo_transacao),
	FOREIGN KEY (codigo_produto) REFERENCES produto(codigo)
)
CREATE TABLE saida
(
	codigo_transacao	CHAR(1) NOT NULL,
	codigo_produto		INT 	NOT NULL,
	quantidade			INT 	NOT NULL,
	valor_total			DECIMAL(7,2),
	PRIMARY KEY (codigo_transacao),
	FOREIGN KEY (codigo_produto) REFERENCES produto(codigo)
)
CREATE PROCEDURE sp_registro
(	@cod 				INT, 
	@nome 				VARCHAR(100), 
	@valor 				DECIMAL(7,2),
	@codigo_transacao	CHAR(1), 
	@codigo_produto		INT,
	@quantidade			INT, 
	@saida				VARCHAR(30) OUTPUT 
)
AS
	DECLARE	@tabela			VARCHAR(10),
			@erro			VARCHAR(MAX),
			@query			VARCHAR(MAX),
			@valor_total	DECIMAL(7, 2)
		SET @valor_total = @quantidade * @valor
		IF @codigo_transacao = 'e'
		BEGIN
			SET @tabela = 'entrada'
			SET @cod = @codigo_produto
		END 
		ELSE  
		IF @codigo_transacao = 's'
		BEGIN
			SET @tabela = 'saida'
			SET @cod = @codigo_produto
		END
		ELSE
		BEGIN
			RAISERROR('Opção de transação inválida', 16, 1)
		END
		SET @query = 'INSERT INTO '+@tabela+' VALUES ('''+@codigo_transacao+''','+CAST(@codigo_produto AS VARCHAR(5))+','
		+CAST(@quantidade AS VARCHAR(5))+','+CAST(@valor_total AS VARCHAR(5))+')'
		BEGIN TRY
		INSERT INTO produto VALUES (@cod, @nome, @valor)
		EXEC (@query)
		SET @saida =  UPPER(@tabela)+' inserido com sucesso'
		END TRY
		BEGIN CATCH
		SET @erro = ERROR_MESSAGE()
		IF (@erro LIKE '%primary%')
		BEGIN
			RAISERROR('Esse ID já existe!', 16, 1)
		END
		ELSE
		BEGIN
			RAISERROR('Erro ao armazenar produto', 16, 1)
		END
	END CATCH
DECLARE @out VARCHAR(30)
EXEC sp_registro 2, 'lapis', 2.99, 's', 2, 8, @out OUTPUT
PRINT @out
select * from produto
select * from entrada
SELECT * FROM saida
delete produto
INSERT INTO entrada VALUES ('e', 1, 10, 3.5)

