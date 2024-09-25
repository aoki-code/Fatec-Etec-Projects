/*

- Uma empresa vende produtos alimentícios

- A empresa dá pontos, para seus clientes, que podem ser revertidos em prêmios

- Para não prejudicar a tabela venda, nenhum produto pode ser deletado, mesmo que não venha mais a ser vendido

- Para não prejudicar os relatórios e a contabilidade, a tabela venda não pode ser alterada. 

- Ao invés de alterar a tabela venda deve-se exibir uma tabela com o nome do último cliente que comprou e o valor da 

última compra

- Após a inserção de cada linha na tabela venda, 10% do total deverá ser transformado em pontos.

- Se o cliente ainda não estiver na tabela de pontos, deve ser inserido automaticamente após sua primeira compra

- Se o cliente atingir 1 ponto, deve receber uma mensagem (PRINT SQL Server) dizendo que ganhou

*/

CREATE DATABASE ex_triggers_07

GO

USE ex_triggers_07

GO

CREATE TABLE cliente (

codigo		INT			NOT NULL,nome		VARCHAR(70)	NOT NULL

PRIMARY KEY(codigo)

)

GO

CREATE TABLE venda (

codigo_venda	INT				NOT NULL,

codigo_cliente	INT				NOT NULL,

valor_total		DECIMAL(7,2)	NOT NULL

PRIMARY KEY (codigo_venda)

FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo)

)

GO

CREATE TABLE pontos (

codigo_cliente	INT					NOT NULL,

total_pontos	DECIMAL(4,1)		NOT NULL

PRIMARY KEY (codigo_cliente)

FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo)

)

CREATE TRIGGER t_blockDelVenda ON Venda

FOR DELETE

AS

BEGIN

	ROLLBACK TRANSACTION

	RAISERROR('Não é permitido excluir registros de vendas', 16, 1)

END

Update Venda set valor_total = 11 where codigo_cliente = 2

select * from Venda

CREATE TRIGGER t_blockUpdateVenda ON Venda

INSTEAD OF UPDATE

AS

BEGIN

	Select TOP 1 c.nome,v.valor_total from Venda v,Cliente c where v.codigo_cliente = c.codigo order by v.codigo_venda DESC

END

CREATE TRIGGER t_transformaEmPontos ON Venda

AFTER INSERT

AS

BEGIN

	declare @pontosVenda as decimal(5,2),@codCliente as int

	set @codCliente = (select codigo_cliente from inserted)

	set @pontosVenda = CONVERT(DECIMAL(16,4),(select valor_total from inserted) * 0.1)

	if (select count(*) from Pontos where codigo_cliente = @codCliente) >= 1

	BEGIN

		update Pontos set  total_pontos = total_pontos + @pontosVenda where codigo_cliente = @codCliente

	END

	ELSE

	BEGIN

		insert into Pontos values (@codCliente,@pontosVenda)

	END

	if (select total_pontos from Pontos where codigo_cliente = @codCliente) >= 1

	BEGIN

		print 'Ganhou'

	END

END
