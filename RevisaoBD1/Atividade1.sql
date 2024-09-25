CREATE DATABASE Atividade1
USE Atividade1

CREATE TABLE aluno(
ra			INT				NOT NULL,
nome		VARCHAR(50)		NOT NULL,
sobrenome   VARCHAR(100)	NOT NULL,
rua			VARCHAR(200)	NOT NULL,
num			INT				NOT NULL,
bairro		VARCHAR(50)		NOT NULL,
cep			CHAR(8)			NOT NULL,
telefone	CHAR(8)			NULL
PRIMARY KEY(ra)
)

CREATE TABLE cursos(
codigo			INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL,
carga_horaria	INT				NOT NULL,
turno			VARCHAR(25)		NOT NULL
PRIMARY KEY(codigo)
)

CREATE TABLE disciplinas(
codigo			INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL,
carga_horaria	INT				NOT NULL,
turno			VARCHAR(25)		NOT NULL,
semestre		INT				NOT NULL
PRIMARY KEY(codigo)
)

INSERT INTO aluno VALUES (12345, 'José', 'Silva', 'Almirante Noronha', 236, 'Jardim São Paulo', '1589000', '69875287'),
(12346, 'Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', '3569000', '25698526'),
(12347, 'Mario', 'Santos', 'XV de Novembro', 1841, 'Centro', '10200030', NULL),
(12348, 'Marcia', 'Neves', 'Voluntários da Pátria', 236, 'Centro', '2785090', '78964152')

INSERT INTO cursos VALUES (1, 'Informática', 2800, 'Tarde'),
(2, 'Informática', 2800, 'Noite'),
(3, 'Logística', 2650, 'Tarde'),
(4, 'Logística', 2650, 'Noite'),
(5, 'Plásticos', 2500, 'Tarde'),
(6, 'Plásticos', 2500, 'Noite')

INSERT INTO disciplinas VALUES (1, 'Informática', 4, 'Tarde', 1),
(2, 'Informática', 4, 'Noite', 1),
(3, 'Química', 4, 'Tarde', 1),
(4, 'Química', 4, 'Noite', 1),
(5, 'Banco de Dados I', 2, 'Tarde', 3),
(6, 'Banco de Dados I', 2, 'Noite', 3),
(7, 'Estrutura de Dados', 4, 'Tarde', 4),
(8, 'Estrutura de Dados', 4, 'Noite', 4)

--Nome e sobrenome, como nome completo dos Alunos Matriculados
SELECT nome + ' ' + sobrenome AS nome_completo 
FROM aluno

--Rua, nº , Bairro e CEP como Endereço do aluno que não tem telefone
SELECT 'Rua ' + rua + ', ' + CAST(num AS VARCHAR(10)) + ', ' + bairro + ' CEP: ' + cep AS endereço
FROM aluno
WHERE telefone IS NULL

--Telefone do aluno com RA 12348
SELECT telefone
FROM aluno
WHERE ra = 12348

--Nome e Turno dos cursos com 2800 horas
SELECT nome, turno
FROM cursos
WHERE carga_horaria = 2800

--O semestre do curso de Banco de Dados I noite
SELECT semestre
FROM disciplinas
WHERE nome = 'Banco de Dados I' 
	AND turno = 'Noite'
