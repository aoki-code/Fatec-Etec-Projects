create database validaCPF
go
use validaCPF

create table cliente
(
	CPF					char(11)		not null,
	Nome				varchar(100)	not null,
	Email				varchar(200)	not null,
	Limite_de_credito	decimal(7,2)	not null,
	Dt_Nascimento		date			not null
	primary key (CPF)
)
CREATE PROCEDURE sp_cliente_validaCPF  (
    @CPF CHAR(11), @digito_1 int, @digito_2 int, @cont_1 int, @cont_2 int, @soma int, @resto int, @valido bit output )

AS
DECLARE @CPF1  char(11),
		@dig_1 int,
		@dig_2 int,
		@cont1 int,
		@cont2 int,
		@soma1 int,
		@resto1 int,
		@valid bit

BEGIN

  /* DIGITOS IDENTICOS */
  IF ( @CPF1 <> 11) OR
  (@CPF1 = '00000000000') OR (@CPF1 = '11111111111') OR
  (@CPF1 = '22222222222') OR (@CPF1 = '33333333333') OR (@CPF1 = '44444444444')OR
  (@CPF1 = '55555555555') OR (@CPF1 = '66666666666') OR (@CPF1 = '77777777777')OR
  (@CPF1 = '88888888888') OR (@CPF1 = '99999999999')
  
  BEGIN
   set @valid = 0;
  END
 
  /* INICIALIZA VARIÁVEIS */
  set @dig_1 = 1;
  set @soma1 = 0;
  set @resto1 = 0;
 
  /* SOMA OS DÍGITOS MULTIPLICADOS E CALCULA O RESTO */
  WHILE (@cont1 <=9) 
  BEGIN
    set @soma1 = @soma1 + CAST( SUBSTRING(@CPF1,1,@cont1) AS int) * (11 - @cont1);
    set @cont1 = @cont1 + 1;
  END
  set @resto1= (@soma1 % 11)
 
  /* TRATA O CASO DE RESTO INFERIOR A 2 */
  if( (@resto1 < 2) AND (SUBSTRING(@CPF1, 1,10) <> '0') )
  BEGIN
    set @valid = 0;
  END
  ELSE
  BEGIN
    /*VERIFICA SE O PRIMEIRO DIGITO CONFERE*/
    IF (11- @resto1<>CAST(SUBSTRING(@CPF1, 1, 10) AS int)) 
    BEGIN
      set @valid=0;
    END
    ELSE
    BEGIN
      set @cont1 = 1;
      set @soma1 = 0;
 
      /*MULTIPLICA, SOMA E CALCULA O RESTO*/
      WHILE (@cont1 <=10)
      BEGIN
        set @soma1 = @soma1 + CAST(SUBSTRING(@CPF1,1, @cont_1) AS int) * (12- @cont1);
        set @cont1 = @cont1 + 1;
      END
      set @resto1 = (@soma1 % 11);
 
      /*VERIFICA O SEGUNDO DÍGITO*/
      IF ((@resto1 < 2) AND (SUBSTRING(@CPF1,1,11) <> '0')) 
      BEGIN
        set @valid=0
      END
      ELSE
      BEGIN
        IF (11 - @resto1 <> CAST(SUBSTRING(@CPF1,1,11) AS int))
        BEGIN
          set @valid=0
        END
        ELSE
        BEGIN
          set @valid=1
        END
      END
    END
  END
 
END
