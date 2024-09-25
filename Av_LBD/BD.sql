CREATE DATABASE campeonato
GO
USE campeonato
GO
CREATE TABLE times(
codTime	INT	NOT NULL,
nomeTime	VARCHAR(25)	NOT NULL,
cidade	VARCHAR(25)	NOT NULL,
estadio VARCHAR(30)	NOT NULL,
materialesportivo VARCHAR(30)	NOT NULL,
fe		BIT	NOT NULL,
fa		BIT	NOT NULL
PRIMARY KEY(codTime)
)
GO
CREATE TABLE grupos(
codGrupo INT NOT NULL,
codTime INT	NOT NULL,
grupo	CHAR(1)	NOT NULL	CHECK(grupo = 'A' OR grupo = 'B' OR grupo = 'C' OR grupo = 'D')
PRIMARY KEY(codGrupo)
FOREIGN KEY(codTime) REFERENCES times(codTime)
)
GO
CREATE TABLE jogos(
codJogo		INT		NOT NULL,
codTimeA	INT		NOT NULL,
codTimeB	INT		NOT NULL,
golsTimeA	INT		NULL,
golsTimeB	INT		NULL,
data_jogo	DATE	NULL,
rodada		INT		NULL
PRIMARY KEY(codJogo)
FOREIGN KEY(codTimeA) REFERENCES times(codTime),
FOREIGN KEY(codTimeB) REFERENCES times(codTime)
)
GO
INSERT INTO times VALUES
(1, 'Água Santa', 'Diadema', 'Distrital do Inamar', 'Karilu', 0, 0),
(2, 'Botafogo-SP', 'Riberão Preto', 'Santa Cruz', 'Volt Sport', 0, 0),
(3, 'Corinthians', 'São Paulo', 'Neo Química Arena', 'Nike', 1, 0),
(4, 'Ferroviária', 'Araraquara','Fonte Luminosa', 'Lupo', 0, 0),
(5, 'Guarani', 'Campinas', 'Brinco de Ouro', 'Kappa', 0, 0),
(6, 'Inter de Limeira', 'Limeira', 'Limerão', 'Alluri Sports', 0, 0),
(7, 'Ituano', 'Itu', 'Novelli Júnior', 'Kanxa', 0, 0),
(8, 'Mirassol', 'Mirassol', 'José Maria de Campos Maia', 'Super Bolla', 0, 0),
(9, 'Novorizontino', 'Novo Horizonte', 'Jorge  Ismael de Biasi', 'Physicus', 0, 0),
(10, 'Palmeiras', 'São Paulo', 'Allianz Parque', 'Puma', 1, 0),
(11, 'Ponte Preta', 'Campinas', 'Moisés Lucarelli', '1900 (Marca Própria)', 0, 0),
(12, 'Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid', 'Nike', 0, 0),
(13, 'Santo André', 'Santo André', 'Bruno José Daniel', 'Icone Sports', 0, 0),
(14, 'Santos', 'Santos', 'Vila Belmiro', 'Umbro', 1, 0),
(15, 'São Bernardo', 'São Bernardo do Campo', 'Primeiro de Maio', 'Magnum Group', 0, 0),
(16, 'São Paulo', 'São Paulo', 'Morumbi', 'Adidas', 1, 0)

CREATE PROCEDURE times(@saida VARCHAR(50) OUTPUT)
	AS
		DELETE grupos 
		DECLARE @grp CHAR(1), @grupos CHAR(4), @cont_grupos INT, @time_especial BIT
		DECLARE @qtd_times INT, @cod_random INT, @valida BIT, @ok BIT, @especial BIT, @id_grupo INT

		SET @grupos = 'ABCD'
		SET @cont_grupos = 1
		SET @id_grupo = 1
		
		WHILE(@cont_grupos < 5)
		BEGIN
			SET @grp = SUBSTRING(@grupos,@cont_grupos,1)
			SET @time_especial = 0
			SET @qtd_times = 1
			WHILE (@qtd_times <= 4)
			BEGIN
				SET @ok = 0 
				WHILE(@ok = 0)
				BEGIN
					IF(@qtd_times = 4 AND @time_especial = 0)
					BEGIN
						WHILE(@time_especial = 0)
						BEGIN
							SET @cod_random = CAST(FLOOR(RAND()*(16-1+1)+1) AS INT)
							SELECT @valida = fa, @especial = fe FROM times WHERE codTime = @cod_random
							IF(@valida = 0 AND @especial = 1 AND @time_especial = 0)
							BEGIN
								INSERT INTO grupos VALUES (@id_grupo, @cod_random,@grp)
								SET @id_grupo = @id_grupo + 1
								UPDATE times SET fa = 1 WHERE codTime = @cod_random
								SET @time_especial = 1
								SET @ok = 1
							END
						END
					END
					IF(@ok = 0)
					BEGIN
						SET @cod_random = CAST(FLOOR(RAND()*(16-1+1)+1) AS INT)
						SELECT @valida = fa, @especial = fe FROM times WHERE codTime = @cod_random
						IF(@valida = 0 AND @especial = 0)
						BEGIN
							INSERT INTO grupos VALUES (@id_grupo, @cod_random, @grp)
							SET @id_grupo = @id_grupo + 1
							UPDATE times SET fa = 1 WHERE codTime = @cod_random
							SET @ok = 1
						END
						ELSE
						BEGIN
							IF(@valida = 0 AND @especial = 1 AND @time_especial = 0)
							BEGIN
								INSERT INTO grupos VALUES (@id_grupo, @cod_random, @grp)
								SET @id_grupo = @id_grupo + 1
								UPDATE times SET fa = 1 WHERE codTime = @cod_random
								SET @time_especial = 1
								SET @ok = 1
							END
						END
					END
				END
				SET @qtd_times = @qtd_times + 1
			END
			SET @cont_grupos = @cont_grupos + 1
		END
		UPDATE times SET fa = 0 

		SET @saida = 'Sucesso!!'


CREATE PROCEDURE rodada (@saida VARCHAR(40) OUTPUT)
AS
BEGIN
    DECLARE @datas TABLE (codData INT IDENTITY(1,1), dt_rodada_dom DATE, dt_rodada_quarta DATE)
    DECLARE @semanas INT = 1, 
            @dt_inicio_dom DATE = '2022-02-21', 
            @dt_inicio_qua DATE = '2022-02-24', 
            @cod INT = 1, 
            @vez INT = 1
    
    DELETE jogos
    
    WHILE (@semanas <= 12)
    BEGIN
        INSERT INTO @datas (dt_rodada_dom, dt_rodada_quarta)
        SELECT CONVERT(DATE, DATEADD(WEEK, @semanas, @dt_inicio_dom)), CONVERT(DATE, DATEADD(WEEK, @semanas, @dt_inicio_qua))
        SET @semanas += 1
    END

    WHILE (@vez <= 4)
    BEGIN
        DECLARE @jogos INT = 1, 
                @data_rodada DATE, 
                @timeA INT, 
                @timeB INT, 
                @reparticao INT = 0
        
        WHILE (@jogos <= 4)
        BEGIN
            SELECT @timeA = codTime FROM grupos WHERE codGrupo = @jogos
            
            IF (@vez = 1) 
            BEGIN
                SET @data_rodada = (SELECT dt_rodada_dom FROM @datas WHERE codData = (@reparticao * 4) + @vez) 
                SELECT @timeB = codTime FROM grupos WHERE codGrupo = @jogos + 4 
            END
            
            IF (@vez = 2)
            BEGIN
                SET @data_rodada = (SELECT dt_rodada_dom FROM @datas WHERE codData = (@reparticao * 4) + @vez)
                SET @timeB = IIF(@jogos = 4, (SELECT codTime FROM grupos WHERE codGrupo = 5), 
                                              (SELECT codTime FROM grupos WHERE codGrupo = @jogos + 5))
            END
            
            IF (@vez = 3)
            BEGIN
                SET @data_rodada = (SELECT dt_rodada_dom FROM @datas WHERE codData = (@reparticao * 4) + @vez)
                SET @timeB = IIF(@jogos IN (1,2), (SELECT codTime FROM grupos WHERE codGrupo = (@jogos + 4) + 2), 
                                                 (SELECT codTime FROM grupos WHERE codGrupo = (@jogos + 4) - 2))
            END
            
            IF (@vez = 4) 
            BEGIN
                SET @data_rodada = (SELECT dt_rodada_dom FROM @datas WHERE codData = (@reparticao * 4) + @vez)
                SET @timeB = IIF(@jogos = 1, (SELECT codTime FROM grupos WHERE codGrupo = (@jogos + 8) - 1), 
                                           (SELECT codTime FROM grupos WHERE codGrupo = (@jogos + 4) - 1))
            END
            
            INSERT INTO jogos (codJogo, codTimeA, codTimeB, dtJogo) 
            SELECT @cod, @timeA, @timeB, @data_rodada
            SET @cod += 1
            SET @jogos += 1
        END
        SET @vez += 1


-- Testeando as saidas
DECLARE @saida_teste VARCHAR(40)
EXEC times @saida_teste OUTPUT
PRINT @saida_teste

SELECT g.codTime, t.nomeTime, g.grupo FROM grupos g, times t WHERE g.codTime = t.codTime ORDER BY grupo

DECLARE @saida VARCHAR(40)
EXEC rodadas @saida OUTPUT
PRINT @saida

SELECT t1.codTime As timeA, t2.codTime timeB, j.golsTimeA, j.golsTimeB, j.data_jogo 
FROM jogos j, times t1, times t2 
WHERE t1.codTime = j.codTimeA
	AND t2.codTime = j.codTimeB
	AND j.rodada = 1
ORDER BY j.data_jogo

SELECT rodada 
FROM jogos
WHERE data_jogo = '2021-02-27'

SELECT * FROM times
SELECT * FROM jogos ORDER BY data_jogo
SELECT * FROM jogos ORDER BY codJogo
SELECT * FROM grupos
