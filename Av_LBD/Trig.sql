CREATE FUNCTION fn_quartas(@grupo CHAR (1))
RETURNS @table TABLE (
nomeTime VARCHAR ( 100 )
)
AS
BEGIN
	INSERT INTO @table
	SELECT  TOP (2) nomeTime FROM fn_placarGrupo(@grupo) ORDER BY pontos DESC , vitorias DESC , gols_marcados DESC , saldo_gols DESC
	RETURN
END

CREATE FUNCTION fn_placarGeral()
RETURNS @pGeral TABLE (
nomeTime VARCHAR(50),
num_jogos_disputados INT,
vitorias INT,
empates INT,
derrotas INT,
gols_marcados INT,
gols_sofridos INT,
saldo_gols INT,
pontos INT
)
AS BEGIN
	
	INSERT INTO @pGeral select * from fn_placarGrupo('A')
	INSERT INTO @pGeral select * from fn_placarGrupo('B')
	INSERT INTO @pGeral select * from fn_placarGrupo('C')
	INSERT INTO @pGeral select * from fn_placarGrupo('D')

	RETURN
END

CREATE PROCEDURE sp_resultado(@nomeTimeA VARCHAR(100), @nomeTimeB VARCHAR(100), @golsTimeA INT, @golsTimeB INT)
AS
	DECLARE @codigoTimeA INT,
			@codigoTimeB INT

	SET @codigoTimeA = (SELECT CodigoTime FROM Times WHERE NomeTime = @nomeTimeA)
	SET @codigoTimeB = (SELECT CodigoTime FROM Times WHERE NomeTime = @nomeTimeB)

	UPDATE Jogos
	SET GolsTimeA = @golsTimeA, GolsTimeB = @golsTimeB
	WHERE CodigoTimeA = @codigoTimeA AND CodigoTimeB = @codigoTimeB

CREATE TRIGGER t_insdltjogos ON jogos
INSTEAD OF INSERT, DELETE
AS
BEGIN
	RAISERROR('Não é possivel modificar os jogos', 16, 1)
END

CREATE TRIGGER t_insupddltgrupos ON grupos
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	RAISERROR('Não é possivel modificar os grupos', 16, 1)
END

CREATE TRIGGER t_insupddlttimes ON times
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	RAISERROR('Não é possivel modificar os times', 16, 1)
END

ENABLE TRIGGER t_insupddlttimes ON times
ENABLE TRIGGER t_insupddltgrupos ON grupos
ENABLE TRIGGER t_insdltjogos ON jogos

DISABLE TRIGGER t_insupddlttimes ON times
DISABLE TRIGGER t_insupddltgrupos ON grupos
DISABLE TRIGGER t_insdltjogos ON jogos

