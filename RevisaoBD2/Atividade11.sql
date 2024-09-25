CREATE DATABASE Atividade11
USE Atividade11

CREATE TABLE plano_de_saude (
codigo                       INT   IDENTITY (1234, 1111)                   NOT NULL,
nome                         VARCHAR(30)                                   NOT NULL,
telefone                     INT                                           NOT NULL
PRIMARY KEY(codigo)
)

CREATE TABLE paciente (
CPF                          VARCHAR(11)              NOT NULL,
nome                         VARCHAR(30)              NOT NULL,
rua                          VARCHAR(40)              NOT NULL,
numero                       INT                      NOT NULL,
bairro                       VARCHAR(40)              NOT NULL,
telefone                     INT                      NOT NULL,
codigo_plano_de_saude        INT                      NOT NULL
PRIMARY KEY(CPF)
FOREIGN KEY(codigo_plano_de_saude)  REFERENCES plano_de_saude(codigo)
)

CREATE TABLE medico (
codigo                      INT                       NOT NULL,
nome                        VARCHAR(20)               NOT NULL,
especialidade               VARCHAR(30)               NOT NULL,
codigo_plano_de_saude       INT                       NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(codigo_plano_de_saude)  REFERENCES plano_de_saude(codigo)            
)

CREATE TABLE consultas (
codigo_medico               INT                       NOT NULL,
CPF_paciente                VARCHAR(11)               NOT NULL,
data_hora                   DATETIME                  NOT NULL,
diagnostico                 VARCHAR(20)               NOT NULL
PRIMARY KEY(codigo_medico, CPF_paciente, data_hora) 
FOREIGN KEY(codigo_medico)    REFERENCES   medico(codigo),
FOREIGN KEY(CPF_paciente)     REFERENCES   paciente(CPF)
)

INSERT INTO plano_de_saude (nome, telefone) VALUES                     
('Amil', 41599856),
('Sul América', 45698745),
('Unimed', 48759836),
('Bradesco Saúde', 47265897),
('Intermédica', 41415269)

INSERT INTO paciente (CPF, nome, rua, numero, bairro, telefone, codigo_plano_de_saude)VALUES              
('85987458920', 'Maria Paula', 'R. Voluntários da Pátria', 589, 'Santana', 98458741, 2345),
('87452136900', 'Ana Julia', 'R. XV de Novembro', 657, 'Centro', 69857412 , 5678),
('23659874100', 'João Carlos', 'R. Sete de Setembro', 12, 'República', 74859632, 1234),
('63259874100', 'José Lima', 'R. Anhaia', 768, 'Barra Funda', 96524156, 2345)

INSERT INTO medico (codigo, nome, especialidade, codigo_plano_de_saude) VALUES             
(1, 'Claudio', 'Clínico Geral', 1234),
(2, 'Larissa', 'Ortopedista', 2345),
(3, 'Juliana', 'Otorrinolaringologista', 4567),
(4, 'Sérgio', 'Pediatra', 1234),
(5, 'Julio', 'Clínico Geral', 4567),
(6, 'Samara', 'Cirurgião', 1234)

INSERT INTO consultas (codigo_medico, CPF_paciente, data_hora, diagnostico) VALUES                
(1, '85987458920', '2021-02-10 10:30:00', 'Gripe'),
(2, '23659874100', '2021-02-10 11:00:00', 'Pé Fraturado'),
(4, '85987458920', '2021-02-11 14:00:00', 'Pneumonia'),
(1, '23659874100', '2021-02-11 15:00:00', 'Asma'),
(3, '87452136900', '2021-02-11 16:00:00', 'Sinusite'),
(5, '63259874100', '2021-02-11 17:00:00', 'Rinite'),
(4, '23659874100', '2021-02-11 18:00:00', 'Asma'),
(5, '63259874100', '2021-02-12 10:00:00', 'Rinoplastia')

--Consultar Nome e especialidade dos médicos da Amil
SELECT m.nome, m.especialidade
FROM medico m, plano_de_saude pds
WHERE m.codigo_plano_de_saude = pds.codigo
    AND pds.nome = 'Amil' 

--Consultar Nome, Endereço concatenado, Telefone e Nome do Plano de Saúde de todos os pacientes
SELECT p.nome, p.rua + ', ' + CAST(p.numero AS VARCHAR(5)) + ', ' + p.bairro AS endereço,
	   p.telefone, pds.nome
FROM paciente p, plano_de_saude pds
WHERE p.codigo_plano_de_saude = pds.codigo

--Consultar Telefone do Plano de  Saúde de Ana Júlia
SELECT pds.nome, pds.telefone
FROM paciente p, plano_de_saude pds
WHERE pds.codigo = p.codigo_plano_de_saude
    AND p.nome LIKE 'Ana J%'

--Consultar Plano de Saúde que não tem pacientes cadastrados
SELECT pds.nome
FROM plano_de_saude pds LEFT OUTER JOIN paciente p
ON pds.codigo = p.codigo_plano_de_saude
WHERE p.codigo_plano_de_saude IS NULL 

--Consultar Planos de Saúde que não tem médicos cadastrados
SELECT pds.nome
FROM plano_de_saude pds LEFT OUTER JOIN medico m
ON pds.codigo = m.codigo_plano_de_saude
WHERE m.codigo_plano_de_saude IS NULL

--Consultar Data da consulta, Hora da consulta, nome do médico, nome do paciente e diagnóstico de todas as consultas
SELECT DISTINCT 
       CONVERT(CHAR(10), CONVERT(DATE, con.data_hora),  103) AS data,
	   CAST(CONVERT(TIME, con.data_hora) AS CHAR(5)) AS hora,
       m.nome AS nome_medico,
	   p.nome AS nome_paciente, con.diagnostico
FROM consultas con, medico m, paciente p
WHERE con.codigo_medico = m.codigo
      AND con.CPF_paciente = p.CPF

--Consultar Nome do médico, data e hora de consulta e diagnóstico de José Lima
SELECT m.nome,
       CONVERT(CHAR(10), CONVERT(DATE, c.data_hora), 103) AS data_consulta,
	   CONVERT(CHAR(5), CONVERT(TIME, c.data_hora)) AS hora_consulta, c.diagnostico
FROM medico m, consultas c, paciente p
WHERE m.codigo = c.codigo_medico
    AND c.CPF_paciente = p.CPF
	AND p.nome LIKE 'Jos%'

--Consultar Diagnóstico e Quantidade de consultas que aquele diagnóstico foi dado (Coluna deve chamar qtd)
SELECT diagnostico,  
      COUNT(diagnostico) AS qtd      
FROM consultas
GROUP BY diagnostico 

--Consultar Quantos Planos de Saúde que não tem médicos cadastrados
SELECT COUNT(pds.codigo) AS qtd
FROM plano_de_saude pds LEFT OUTER JOIN medico m
ON pds.codigo = m.codigo_plano_de_saude
WHERE m.codigo_plano_de_saude IS NULL

--Alterar o nome de João Carlos para João Carlos da Silva
UPDATE paciente
SET nome = 'João Carlos da Silva'
WHERE nome = 'João Carlos'

--Deletar o plano de Saúde Unimed
DELETE plano_de_saude
WHERE nome = 'Unimed'

--Renomear a coluna Rua da tabela Paciente para Logradouro
EXEC sp_rename  'dbo.paciente.rua', 'Logradouro', 'column'

--Inserir uma coluna, na tabela Paciente, de nome data_nasc e 
--inserir os valores (1990-04-18,1981-03-25,2004-09-04 e 1986-06-18) respectivamente
ALTER TABLE paciente
ADD data_nasc DATE NULL

UPDATE paciente 
SET data_nasc = ('1990-04-18')
WHERE CPF = '23659874100'       

UPDATE paciente 
SET data_nasc = ('1981-03-25')
WHERE CPF = '63259874100'       

UPDATE paciente 
SET data_nasc = ('2004-09-04')
WHERE CPF = '85987458920'       

UPDATE paciente 
SET data_nasc = ('1990-04-18')
WHERE CPF = '87452136900'