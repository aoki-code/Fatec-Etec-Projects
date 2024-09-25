CREATE DATABASE fatec
GO 
USE fatec

CREATE TABLE aluno 
(
	ra CHAR(13)       not null,
	nome VARCHAR(100) NOT NULL
	primary key (ra)
)

CREATE TABLE disciplina
(
	codigo CHAR(8) not null,
	nome VARCHAR(100) NOT NULL,
	sigla CHAR(6) NOT NULL,
	curso VARCHAR(5) NOT NULL,
	turno VARCHAR(10) NOT NULL,
	num_aula int NOT NULL
	primary key (codigo)
)

CREATE TABLE faltas 
(
	ra_aluno CHAR(13),
	codigo_disciplina CHAR(8), 
	data DATE NOT NULL, 
	falta int 
	PRIMARY KEY (ra_aluno, codigo_disciplina, data),
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra),
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
)

CREATE TABLE avaliacao 
(
	codigo int IDENTITY(100,1) PRIMARY KEY,
	codigo_disciplina CHAR(8), 
	tipo VARCHAR(10),
	peso DECIMAL(7,2)
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
)

CREATE TABLE notas
(
	ra_aluno CHAR(13),
	codigo_disciplina CHAR(8),
	codigo_avaliação int,
	nota DECIMAL(7,2),
	PRIMARY KEY (ra_aluno,codigo_disciplina,codigo_avaliação),
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra),
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
	FOREIGN KEY (codigo_avaliação) REFERENCES avaliacao(codigo)
)

SELECT ra, nome FROM aluno 
SELECT * FROM avaliacao

INSERT INTO aluno VALUES
('1234567890123', 'Fulano'),
('2345678901234', 'Cicrano'),
('3456789012345', 'Beltrano'),
('4567890123456', 'Fulaninho'),
('5678901234567', 'Cicraninho'),
('6789012345678', 'Beltraninho'),
('7890123456789', 'Fulano Junior'),
('8901234567890', 'Cicrano Junior'),
('9012345678901', 'Beltrano Junior')

--SELECT * FROM aluno


INSERT INTO disciplina VALUES 
('1111-111', 'Exame', 'EXE001', 'TODOS', 'TODOS', 0),
('4203-010', 'Arquitetura e Organização de Computadores', 'IAC001', 'ADS', 'Tarde', 80),
('4203-020', 'Arquitetura e Organização de Computadores', 'IAC001', 'ADS', 'Noite', 80),
('4208-010', 'Laboratório de Hardware', 'IHW100', 'ADS', 'Tarde', 40),
('4226-004', 'Banco de Dados', 'IBD002', 'ADS', 'Tarde', 80),
('4213-003', 'Sistemas Operacionais I', 'ISO100', 'ADS', 'Tarde', 80),
('4213-013', 'Sistemas Operacionais I', 'ISO100', 'ADS', 'Noite', 80),
('4233-005', 'Laboratório de Banco de Dados', 'IBD100', 'ADS', 'Tarde', 80),
('4203-011', 'Métodos Para a Produção do Conhecimento', 'IMC001', 'COMEX', 'Tarde', 40)

--SELECT * FROM disciplina

INSERT INTO avaliacao VALUES
('4213-003','Pre Exame', 0.2),
('4213-013','Pre Exame', 0.2),
('1111-111','Exame', 0.5),
('4203-010','P1', 0.3),
('4203-010','P2', 0.5),
('4203-010','T', 0.2),
('4203-020','P1', 0.3),
('4203-020','P2', 0.5),
('4203-020','T', 0.2),
('4208-010','P1', 0.3),
('4208-010','P2', 0.5),
('4208-010','T', 0.2),
('4226-004','P1', 0.3),
('4226-004','P2', 0.5),
('4226-004','T', 0.2),
('4213-003','P1', 0.35),
('4213-003','P2', 0.35),
('4213-003','T', 0.3),
('4213-013','P1', 0.35),
('4213-013','P2', 0.35),
('4213-013','T', 0.3),
('4203-011','Mono Comp', 0.8),
('4203-011','Mono Resu', 0.2),
('4233-005','P1', 0.333),
('4233-005','P2', 0.333),
('4233-005','P3', 0.333)

--SELECT * FROM avaliacao

--==============================================================================================================
--==================================== Procedure para inserir notas ============================================
--==============================================================================================================


CREATE PROCEDURE SP_Nota_INS (@ra_aluno CHAR(13),  @codigo_avaliação int, @nota DECIMAL(7,2))
AS

    IF ((@nota <= 10) AND (@nota >= 0))
    BEGIN 

        DECLARE @codigo_disciplina CHAR(8)
        SET @codigo_disciplina = (SELECT codigo_disciplina FROM avaliacao WHERE codigo = @codigo_avaliação)

        DECLARE @cont int
        SET @cont = (SELECT count(ra_aluno) FROM notas 
            WHERE ra_aluno = @ra_aluno AND codigo_avaliação = @codigo_avaliação)

        IF @cont > 0
        BEGIN 
            UPDATE notas SET nota = @nota WHERE ra_aluno = @ra_aluno AND codigo_avaliação = @codigo_avaliação;
        END
        ELSE
        BEGIN
            INSERT INTO notas VALUES (@ra_aluno, @codigo_disciplina, @codigo_avaliação, @nota)
        END
    END
    ELSE
    BEGIN
        RAISERROR ('A NOTA NÃO É VALIDA', 16,1)
    END




--==============================================================================================================
--==================================== Procedure para inserir faltas ===========================================
--==============================================================================================================

CREATE PROCEDURE SP_Faltas_INS (@RA CHAR(13), @cod_disc CHAR(8), @dt DATE, @qnt_falta int)
AS

	-- CONFERE SE O NUMERO DE FALTAS MARCADAS PELO PROFESSOR É MAIOR QUE O NUMERO DE AULAS POR DIA

	DECLARE @qnt_aulas int
	SET @qnt_aulas = (SELECT num_aula FROM disciplina WHERE codigo = @cod_disc) / 20

	print @qnt_aulas

	--Se o numero for maior que o permitido retorna um aviso

	IF @qnt_aulas < @qnt_falta
	BEGIN
		Select 'NÃO É VALIDO ESSA QUANTIDADE DE FALTAS' as Mensagem
	END
	ELSE
	BEGIN
		-- Se o professor não inserir a data pega a atual
		IF (@dt is null)
		BEGIN
			SET @dt = GETDATE()
		END 

		-- Confere se o aluno nessa data já tem alguma falta marcada

		DECLARE @cont int

		SET @cont = (SELECT count(ra_aluno) FROM faltas WHERE ra_aluno = @RA AND codigo_disciplina = @cod_disc AND data = @dt)

		-- Se já tem falta só atualiza se não tem, insere

		IF (@cont > 0)
		BEGIN
			UPDATE faltas SET falta = @qnt_falta WHERE ra_aluno = @RA AND codigo_disciplina = @cod_disc AND data = @dt;
		END
		ELSE
		BEGIN
			INSERT INTO faltas VALUES (@RA, @cod_disc, @dt, @qnt_falta)
		END
	END


--==============================================================================================================
--==================================== FUNÇÃO para mostrar notas ===============================================
--==============================================================================================================

CREATE FUNCTION FN_Media_SEL (@codigo_diciplina CHAR(8))
RETURNS @table TABLE 
(
	ra_aluno CHAR(13),
	nome_aluno VARCHAR(100),
	nota1 DECIMAL(7,1),
	nota2 DECIMAL(7,1),
	nota3 DECIMAL(7,1),
	nota4 DECIMAL(7,1),
	exame DECIMAL(7,1),
	media_final DECIMAL(7,1),
	situacao VARCHAR(9),
	disciplina VARCHAR(50)
)
AS 
BEGIN

	DECLARE 
	@ra_aluno CHAR(13),
	@codigo_avaliacao int,
	@nota DECIMAL(7,2),
	@tipo VARCHAR(10),
	@peso DECIMAL(7,2), 
	@media DECIMAL(7,2),
	@media_final DECIMAL(7,2),
	@exame DECIMAL(7,2)


	INSERT INTO @table (ra_aluno, nome_aluno, media_final, disciplina)
		SELECT a.ra, a.nome, 0, d.nome FROM aluno a, disciplina d WHERE d.codigo = @codigo_diciplina 
	
	DECLARE c_notas CURSOR FOR SELECT ra_aluno, codigo_avaliação, nota FROM notas 
	WHERE @codigo_diciplina = codigo_disciplina OR codigo_disciplina = '1111-111' ORDER BY ra_aluno, codigo_avaliação ASC 

	OPEN c_notas
	FETCH NEXT FROM c_notas INTO @ra_aluno, @codigo_avaliacao, @nota

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @peso = (SELECT peso FROM avaliacao WHERE codigo = @codigo_avaliacao)
		SET @tipo = (SELECT tipo FROM avaliacao WHERE codigo = @codigo_avaliacao)
		
		SET @media = (@nota*@peso)

		IF (@tipo = 'P1' OR @tipo = 'Mono Comp')
		BEGIN 
			UPDATE @table SET nota1 = @nota, media_final = media_final + @media WHERE ra_aluno = @ra_aluno
		END 

		IF (@tipo = 'P2' OR @tipo = 'Mono Resu')
		BEGIN 
			UPDATE @table SET nota2 = @nota, media_final = media_final + @media WHERE ra_aluno = @ra_aluno
		END 

		IF (@tipo = 'P3' OR @tipo = 'T')
		BEGIN 
			UPDATE @table SET nota3 = @nota, media_final = media_final + @media WHERE ra_aluno = @ra_aluno
		END

		SET @media_final = (SELECT media_final FROM @table WHERE ra_aluno = @ra_aluno)
		
		IF(@media_final > 3 AND @media_final < 6)
		BEGIN 
			IF (@tipo = 'Pre Exame')
			BEGIN 
				UPDATE @table SET nota4 = @nota, media_final = media_final + @media WHERE ra_aluno = @ra_aluno
			END

			IF (@tipo = 'Exame')
			BEGIN 
				UPDATE @table SET exame = @nota, media_final = (media_final*0.5) + @media WHERE ra_aluno = @ra_aluno
			END
		END 
		
		SET @media_final = (SELECT media_final FROM @table WHERE ra_aluno = @ra_aluno)
		SET @exame = (SELECT exame FROM @table WHERE ra_aluno = @ra_aluno)

		-- Calcular Situação

		UPDATE @table SET situacao = (SELECT dbo.fn_calc_situacao(@ra_aluno, @media_final, @codigo_diciplina, @exame)) WHERE ra_aluno = @ra_aluno 

		FETCH NEXT FROM c_notas INTO @ra_aluno, @codigo_avaliacao, @nota
	END

	
	CLOSE c_notas
	DEALLOCATE c_notas

	RETURN 
END 
GO

CREATE FUNCTION fn_calc_situacao(@ra CHAR(13), @media DECIMAL(7,2), @codigo_disciplina CHAR(8), @exame DECIMAL(7,2))
RETURNS VARCHAR(9)
AS
BEGIN
	DECLARE @situacao VARCHAR(9),
			@limite int, 
			@faltas int

	SET @faltas = (SELECT dbo.fn_calc_total_faltas(@ra, @codigo_disciplina))

	SET @limite = (SELECT num_aula FROM disciplina WHERE @codigo_disciplina = codigo) * 0.25

	IF(@faltas > @limite)
	BEGIN
		SET @situacao = 'REPROVADO POR FALTA'
	END
	ELSE 
	BEGIN 
		
		IF (@media < 6 )
		BEGIN 
			SET @situacao = 'REPROVADO'
			IF ((@exame IS NULL) AND (@media > 3))
			BEGIN 
				SET @situacao = 'EXAME'
			END 
		END 
		ELSE 
		BEGIN
			SET @situacao = 'APROVADO'
		END 

	END 
	RETURN (@situacao)
END


CREATE FUNCTION fn_calc_total_faltas(@ra CHAR(13), @codigo_disciplina CHAR(8))
RETURNS INT
AS
BEGIN
	DECLARE @faltas INT

	SET @faltas = (SELECT SUM(falta) FROM faltas WHERE ra_aluno = @ra AND codigo_disciplina = @codigo_disciplina)

	RETURN (@faltas)
END


--==============================================================================================================
--==================================== FUNÇÃO para mostrar faltas ==============================================
--==============================================================================================================

CREATE FUNCTION FN_Falta(@disciplina char(11))

RETURNS @tabFalta TABLE
(
	ra CHAR(13),
	nome Varchar(250),
	semana1 char(4),
	semana2 char(4),
	semana3 char(4),
	semana4 char(4),
	semana5 char(4),
	semana6 char(4),
	semana7 char(4),
	semana8 char(4),
	semana9 char(4),
	semana10 char(4),
	semana11 char(4),
	semana12 char(4),
	semana13 char(4),
	semana14 char(4),
	semana15 char(4),
	semana16 char(4),
	semana17 char(4),
	semana18 char(4),
	semana19 char(4),
	semana20 CHAR(4),
	total int,
	disciplina VARCHAR(50)
)
AS
	BEGIN
	DECLARE @raUso char(13)
	DECLARE @ra_aluno varchar(20)
	DECLARE @presenca VARCHAR(20)
	DECLARE @cont int
	set @raUso = ''

	--INSERE O RA E NOME DO ALUNO

	INSERT  @tabFalta (ra, nome, total, disciplina) 
		SELECT DISTINCT faltas.ra_aluno, aluno.nome, 0, disciplina.nome
		from faltas INNER JOIN aluno
		ON faltas.ra_aluno = aluno.ra, disciplina  
		WHERE codigo_disciplina = @disciplina and disciplina.codigo = @disciplina

	DECLARE c CURSOR FOR SELECT ra_aluno, falta FROM faltas WHERE codigo_disciplina = @disciplina order by ra_aluno,data

	OPEN c
		FETCH NEXT FROM c INTO @ra_aluno, @presenca 

		WHILE @@FETCH_STATUS = 0
		BEGIN
			
			UPDATE @tabFalta SET total = (total+@presenca) where ra = @ra_aluno
			
			IF (@raUso != @ra_aluno)
			BEGIN
				set @raUso = @ra_aluno
				set @cont = 1
			END

			IF (@cont = 1)
			BEGIN
				UPDATE @tabFalta SET semana1 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 2)
			BEGIN
				UPDATE @tabFalta SET semana2 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 3)
			BEGIN
				UPDATE @tabFalta SET semana3 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 4)
			BEGIN
				UPDATE @tabFalta SET semana4 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 5)
			BEGIN
				UPDATE @tabFalta SET semana5 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 6)
			BEGIN
				UPDATE @tabFalta SET semana6 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 7)
			BEGIN
				UPDATE @tabFalta SET semana7 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 8)
			BEGIN
				UPDATE @tabFalta SET semana8 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 9)
			BEGIN
				UPDATE @tabFalta SET semana9 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END
			
			IF (@cont = 10)
			BEGIN
				UPDATE @tabFalta SET semana10 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 11)
			BEGIN
				UPDATE @tabFalta SET semana11 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 12)
			BEGIN
				UPDATE @tabFalta SET semana12 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 13)
			BEGIN
				UPDATE @tabFalta SET semana13 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 14)
			BEGIN
				UPDATE @tabFalta SET semana14 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 15)
			BEGIN
				UPDATE @tabFalta SET semana15 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 16)
			BEGIN
				UPDATE @tabFalta SET semana16 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 17)
			BEGIN
				UPDATE @tabFalta SET semana17 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 18)
			BEGIN
				UPDATE @tabFalta SET semana18 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			IF (@cont = 19)
			BEGIN
				UPDATE @tabFalta SET semana19 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END
			
			IF (@cont = 20)
			BEGIN
				UPDATE @tabFalta SET semana20 = (SELECT dbo.FN_semanaFalta(@presenca)) where ra = @ra_aluno
			END

			SET @cont = @cont + 1
			FETCH NEXT FROM c INTO @ra_aluno, @presenca 
		END

	RETURN
END

--==============================================================================================================
--==================================== PROCEDURE QUE CONVERTE EM LETRA =========================================
--==============================================================================================================


CREATE FUNCTION FN_semanaFalta (@semanas int)
RETURNS CHAR(4)
AS 
BEGIN
	
	DECLARE @retorno CHAR(4)

	IF @semanas = 0
	BEGIN
		set @retorno = 'PPPP'
	END

	IF @semanas = 1
	BEGIN
		set @retorno = 'FPPP'
	END

	IF @semanas = 2
	BEGIN
		set @retorno = 'FFPP'
	END

	IF @semanas = 3
	BEGIN
		set @retorno = 'FFFP'
	END

	IF @semanas = 4
	BEGIN
		set @retorno = 'FFFF'
	END

	RETURN @retorno
END


select f.ra_aluno,
	   a.nome,
	   f.codigo_disciplina,
	   d.nome,
	   f.falta, convert (char(10),f.data,103) as dt_aula
from faltas f, aluno a, disciplina d
order by data 

select a.ra, a.nome, d.curso , d.codigo, d.nome, 
f.falta, convert (char(10),f.data,103) as dt_aula
from aluno a, disciplina d, faltas f
where d.codigo = '4226-004'

select f.ra_aluno,
	   a.nome,
	   f.codigo_disciplina,
	   d.nome,
	   f.falta, convert (char(10),f.data,103) as dt_aula
from faltas f, aluno a, disciplina d
order by data
-------------------------------------------------------------
--funcionando
select f.ra_aluno, a.nome, f.codigo_disciplina, d.nome, 
		convert (char(10),f.data,103) as dt_aula, f.falta 
from faltas f, aluno a, disciplina d
where a.ra = f.ra_aluno
and f.codigo_disciplina = d.codigo

-------------------------------------------------------------
select f.ra_aluno, a.nome, f.codigo_disciplina, d.nome, 
		convert (char(10),f.data,103) as dt_aula, f.falta 
from faltas f, aluno a, disciplina d
where a.ra = f.ra_aluno
and d.codigo = '4226-004'

--------------------------------------------------------------

select distinct a.ra, a.nome, d.curso , d.codigo, d.nome, 
f.falta, convert (char(10),f.data,103) as dt_aula
from aluno a, disciplina d, faltas f
where d.codigo = '4226-004'
order by dt_aula 



