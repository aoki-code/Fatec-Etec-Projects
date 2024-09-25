CREATE DATABASE exerc_cpf
GO
USE exerc_cpf

CREATE TABLE pessoa(
cpf VARCHAR(11) NOT NULL,
nome VARCHAR(200) NOT NULL
PRIMARY KEY (cpf)
)

CREATE PROCEDURE sp_validacaoCPF(@cpf VARCHAR(11), @saida VARCHAR(MAX) OUTPUT)
AS
	IF (LEN(@cpf) != 11)
	BEGIN
		RAISERROR('CPF inválido',16,1)
	END
	ELSE
	BEGIN 
		DECLARE @cont INT,
				@digito VARCHAR(1),
				@resp INT,
				@soma INT,
				@d1 INT,
				@d2 INT
		  
		SET @digito = SUBSTRING(@cpf,1,1)

		SET @cont = 1
		SET @resp = 1

		WHILE (@cont <= 11)
		BEGIN
			IF (SUBSTRING(@cpf,@cont,1) <> @digito)
			BEGIN
				SET @resp = 0
			END
			SET @cont = @cont + 1
		END

		IF (@resp = 0)
		BEGIN
			SET @cont = 1
			SET @soma = 0

			WHILE (@cont <= 9)
			BEGIN
				SET @soma = @soma +( convert(INT,substring(@cpf, @cont,1)) * (11 - @cont))
				SET @cont = @cont + 1
			END
	
			SET @d1 = 11 - (@soma % 11)

			IF (@d1 > 9)
			BEGIN
				SET @d1 = 0
			END

			SET @cont = 1
			SET @soma = 0

			WHILE (@cont <= 10)
			BEGIN
				SET @soma = @soma + (convert(INT,substring(@cpf, @cont,1)) * (12 - @cont))
				SET @cont = @cont + 1
			END
		
			SET @d2 = 11 - (@soma % 11)

			IF (@d2 > 9)
			BEGIN
				SET @d2 = 0
			END

			IF(@d1 = SUBSTRING(@cpf,LEN(@cpf)-1,1)) AND (@d2 = SUBSTRING(@cpf,LEN(@cpf),1))
			BEGIN
				SET @saida = 'Válido'
			END
			ELSE
			BEGIN
				SET @saida = 'Inválido'
			END
		END
		ELSE
		BEGIN
			RAISERROR('Todos os digitos iguais',16,1)
		END
	END


DECLARE @out VARCHAR(MAX)
EXEC sp_validacaoCPF '22222222222', @out OUTPUT
PRINT @out

CREATE PROCEDURE sp_inserePessoa(@cpf VARCHAR(11),@nome VARCHAR(200), @saida VARCHAR(MAX) OUTPUT)
AS
	DECLARE  @out VARCHAR(MAX)

	EXEC sp_validacaoCPF @cpf, @out OUTPUT

	IF(@out = 'Válido')
	BEGIN
		INSERT INTO pessoa VALUES (@cpf,@nome)
		SET @saida = 'Inserido com sucesso'
	END
	ELSE
	BEGIN
		SET @saida = 'Erro'
	END

DECLARE @out2 VARCHAR(MAX)
EXEC sp_inserePessoa '11111111111', 'Teste', @out2 OUTPUT
PRINT @out2

SELECT * FROM pessoa