CREATE FUNCTION fn_TeinoCursor()

RETURNS @tabela_Cursor TABLE(

cod_Disciplina INT,

Nome_disciplina VARCHAR(MAX),

Carga_Horaria_disciplina INT,

nome_curso VARCHAR(MAX)

)

AS

 BEGIN

   DECLARE

     @cod_curso INT,

	 @c_dis INT,	 @cod_Disciplina INT,

	 @Nome_disciplina VARCHAR(MAX),

	 @Carga_Horaria_disciplina INT,

	 @nome_curso VARCHAR(MAX)

    DECLARE cursor_curso CURSOR FOR

	SELECT cod_curso,cod_dis FROM disciplina_curso

    OPEN cursor_curso

    FETCH NEXT FROM cursor_curso

	INTO  @cod_curso,@c_dis

    WHILE @@FETCH_STATUS = 0

    BEGIN

	  SELECT @cod_Disciplina = di.cod,

	  @Nome_disciplina=di.nome,

	  @Carga_Horaria_disciplina=di.carga_horaria,

	  @nome_curso=cur.nome

	  FROM disciplinas di

	  INNER JOIN disciplina_curso dis

	  ON di.cod=dis.cod_dis

	  INNER JOIN curso cur

	  ON cur.codigo=dis.cod_curso

	  WHERE dis.cod_curso=@cod_curso AND dis.cod_dis=@c_dis

	  INSERT INTO @tabela_Cursor VALUES 

	  (@cod_disciplina,@Nome_disciplina,@Carga_Horaria_disciplina,@nome_curso)

			

    FETCH NEXT FROM cursor_curso INTO @cod_curso,@c_dis

    END

    CLOSE cursor_curso

    DEALLOCATE cursor_curso

    RETURN

END
