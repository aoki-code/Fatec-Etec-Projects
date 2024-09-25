create database bd_produto
use bd_produto

create table produto
(
	codigo			int not null,
	nome			varchar(30),
	valor_unitario	decimal(7,2),
	qtd_estoque		int
	primary key (codigo)
)

create procedure sp_produto( @op char(1), @codigo int, 
		@nome varchar(100), @valor_unitario decimal(7,2), @qtd_estoque int,
		@saida varchar(max) output)
as
	if(UPPER(@op) = 'D' and @codigo is not null)
	begin
		delete produto where codigo = @codigo
		set @saida = 'Pessoa #ID ' + cast(@codigo as varchar(5)) + ' excluida'
	end
	else
	begin
		if(UPPER(@op) = 'D' and @codigo is null)
		begin
			raiserror('#ID invalido', 16, 1)
		end
		else
		begin
			if(UPPER(@op) = 'I')
			begin
				insert into produto values
				(@codigo, @nome, @valor_unitario, @qtd_estoque)

				set @saida = 'Produto #ID' + CAST(@codigo as varchar(5)) +
							' inserida com sucesso'
			end
			else
			begin
				if(UPPER(@op) = 'U')
				begin
					update produto
					set nome = @nome, valor_unitario = @valor_unitario,
						qtd_estoque = @qtd_estoque
					where codigo = @codigo

					set @saida = 'Produto #ID ' + 
						cast(@codigo as varchar(5))+
						' atualizada com sucesso' 
				end
				else
				begin
					raiserror('Operacao de codigo invalido', 16, 1)
				end
			end
		end
	end

	declare @saida varchar(max)
	exec sp_produto 'u', 1, 'Caderno', 5.99, 10, @saida output 
	print @saida

	declare @saida varchar(max)
	exec sp_produto 'i', 2, 'Caneta', 1.99, 8, @saida output 
	print @saida

	declare @saida varchar(max)
	exec sp_produto 'i', 3, 'Lapis', 0.99, 3, @saida output 
	print @saida

	declare @saida varchar(max)
	exec sp_produto 'i', 4, 'Borracha', 3.99, 0, @saida output 
	print @saida

	select * from produto



----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------


	--Função Escalar
CREATE FUNCTION fn_prod(@codigo INT)
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @nome				varchar(100),
			@valor_unitario		DECIMAL(7,2),
			@qtd_estoque		INT

	SELECT @nome = nome, @valor_unitario = valor_unitario, @qtd_estoque = qtd_estoque FROM produto
		WHERE codigo = @codigo
	
	--SET @qtd_estoque
	RETURN @qtd_estoque
END
 
SELECT dbo.fn_prod(1) AS qtd_estoque
 
--Exemplo 2 - Multi Statement Table
CREATE FUNCTION fn_tabelaprod()
RETURNS @tabela TABLE (
codigo			INT,
nome			VARCHAR(100),
valor_unitario	DECIMAL(7,2),
qtd_estoque		INT,
condicao		VARCHAR(22)
)
AS
BEGIN
	INSERT INTO @tabela(codigo, nome, valor_unitario, qtd_estoque)
		SELECT codigo, nome, valor_unitario, qtd_estoque FROM produto
 
	UPDATE @tabela SET qtd_estoque = (SELECT dbo.fn_prod(codigo))
 
	UPDATE @tabela SET condicao = 'Sem estoque'
		WHERE qtd_estoque = 0
	UPDATE @tabela SET condicao = 'Estoque baixo'
		WHERE qtd_estoque > 1 AND qtd_estoque < 9
	UPDATE @tabela SET condicao = 'Em estoque'
		WHERE qtd_estoque >= 10

	RETURN 
END
 
SELECT * FROM fn_tabelaprod()
 
