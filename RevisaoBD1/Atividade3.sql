CREATE DATABASE Atividade3
USE Atividade3

CREATE TABLE pacientes(
CPF				CHAR(12)		NOT NULL,
nome			VARCHAR(150)	NOT NULL,
rua				VARCHAR(200)	NOT NULL,
num				INT				NOT NULL,
bairro			VARCHAR(80)		NOT NULL,
telefone		CHAR(8)			NULL,
data_nasc		DATETIME		NOT NULL
PRIMARY KEY(CPF)
)

CREATE TABLE medico(
codigo			INT				NOT NULL,
nome			VARCHAR(150)	NOT NULL,
especialidade	VARCHAR(100)	NOT NULL
PRIMARY KEY(codigo)
)

CREATE TABLE prontuario(
data			DATETIME		NOT NULL,
CPF_paciente	CHAR(12)		NOT NULL,
codigo_medico	INT				NOT NULL,
diagnostico		VARCHAR(150)	NOT NULL,
medicamento		VARCHAR(150)	NOT NULL
PRIMARY KEY(data, CPF_paciente, codigo_medico)
FOREIGN KEY(CPF_paciente)
	REFERENCES pacientes(CPF),
FOREIGN KEY(codigo_medico)
	REFERENCES medico(codigo)
)

INSERT INTO pacientes VALUES ('35454562890', 'José Rubens', 'Campos Salles', 2750, 'Centro', '21450998', '18/10/1954'),
('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', '97382764', '29/05/1960'),
('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236, 'Vila Galvão', '68172651', '24/09/1980'),
('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Rosália', NULL, '30/03/1975'),
('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', '21276578', '24/04/1944')

INSERT INTO medico VALUES (1, 'Wilson Cesar', 'Pediatra'),
(2, 'Marcia Matos', 'Geriatra'),
(3, 'Carolina Oliveira', 'Pediatra'),
(4, 'Vinicius Araujo', 'Clínico Geral')

INSERT INTO prontuario VALUES ('10/09/2020', '35454562890', 2, 'Reumatismo', 'Celebra'),
('10/09/2020','92173458910', 2, 'Renite Alérgica', 'Allegra'),
('12/09/2020','29865439810', 1,	'Inflamação de garganta', 'Nimesulida'),
('13/09/2020','35454562890', 2, 'H1N1',	'Tamiflu'),
('15/09/2020', '12386758770', 3, 'Braço Quebrado','Dorflex + Gesso')

INSERT INTO prontuario VALUES ('15/09/2020', '82176534800', 4, 'Gripe', 'Resprin')

--Alterar o telefone da paciente Maria Rita, para 98345621
UPDATE pacientes
SET telefone = '98345621'
WHERE CPF = '12386758770'

--Alterar o Endereço de Joana de Souza para Voluntários da Pátria, 1980, Jd. Aeroporto
UPDATE pacientes
SET rua = 'Voluntários da Pátrias',
	num = 1980,
	bairro = 'Jd. Aeroporto'
WHERE CPF = '92173458910'

--Nome e Endereço (concatenado) dos pacientes com mais de 50 anos
SELECT nome, 'Rua ' + rua + ', ' + CAST(num AS VARCHAR(5)) + ' - ' + bairro AS endereço
FROM pacientes
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 50

--Qual a especialidade de Carolina Oliveira
SELECT especialidade
FROM medico
WHERE nome LIKE '%Carolina%'

--Qual medicamento receitado para reumatismo
SELECT medicamento
FROM prontuario
WHERE diagnostico LIKE '%Reumatismo%'

--Diagnóstico e Medicamento do paciente José Rubens em suas consultas
SELECT diagnostico, medicamento
FROM prontuario
WHERE CPF_paciente IN
(
	SELECT CPF
	FROM pacientes
	WHERE nome LIKE '%José%'
)

--Nome e especialidade do(s) Médico(s) que atenderam José Rubens. Caso a especialidade tenha mais de 3 letras, mostrar apenas as 3 primeiras letras concatenada com um ponto final (.)
SELECT nome, 
CASE WHEN LEN(especialidade) < 3
	THEN especialidade
	ELSE SUBSTRING(especialidade, 1, 3) + '.'
	END AS especialidade
FROM medico
WHERE codigo IN
(
	SELECT codigo_medico
	FROM prontuario
	WHERE CPF_paciente =
	(
		SELECT CPF
		FROM pacientes
		WHERE nome LIKE '%José%'
	)
)

--CPF (Com a máscara XXX.XXX.XXX-XX), Nome, Endereço completo (Rua, nº - Bairro), Telefone (Caso nulo, mostrar um traço (-)) dos pacientes do médico Vinicius
SELECT SUBSTRING(CPF, 1, 3) + '.' + SUBSTRING(CPF, 4, 3) + '.' + SUBSTRING(CPF, 7, 3) + '-' + SUBSTRING (CPF, 10, 2) AS CPF,
nome,'Rua ' + rua + ', ' + CAST(num AS VARCHAR(5)) + ' - ' + bairro AS endereço,
CASE WHEN telefone IS NULL
	THEN '-'
	ELSE telefone 
	END AS telefone
FROM pacientes
WHERE CPF IN
(
	SELECT CPF_paciente
	FROM prontuario
	WHERE codigo_medico =
	(
		SELECT codigo
		FROM medico
		WHERE nome LIKE '%Vinicius%'
	)
)

--Quantos dias fazem da consulta de Maria Rita até hoje
SELECT DATEDIFF(DAY, data, GETDATE()) AS total_dias_consulta
FROM prontuario
WHERE CPF_paciente IN
(
	SELECT CPF
	FROM pacientes
	WHERE nome LIKE '%Maria%'
)