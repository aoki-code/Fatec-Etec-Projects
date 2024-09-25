CREATE DATABASE Clinica;

USE clinica;

CREATE TABLE paciente (
num_beneficiario 	int 			NOT NULL,
nome 				VARCHAR(100)	NOT NULL,
logradouro 			VARCHAR(200)	NOT NULL,
numero 				INT				NOT NULL,
CEP 				CHAR(8)			NULL,
complemento 		VARCHAR(255)	NULL,
telefone 			VARCHAR(11)		NOT NULL,
PRIMARY KEY (num_beneficiario)
);

CREATE TABLE especialidade (
id				INT				NOT NULL,
especialidade 	VARCHAR(200)	NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE medico (
codigo				INT				NOT NULL,
nome				VARCHAR(100)	NOT NULL,
logradouro			VARCHAR(200)	NOT NULL,
numero				INT				NOT NULL,
CEP					CHAR(8)			NOT NULL,
complemento			VARCHAR(255)	NULL,
contato				VARCHAR(11)		NOT NULL,
especialidade_id	INT				NOT NULL,
PRIMARY KEY (codigo),
FOREIGN KEY (especialidade_id)
REFERENCES especialidade (id)
);

CREATE TABLE consulta (
paciente_num_beneficiario	INT				NOT NULL,
medico_codigo				INT				NOT NULL,
data_hora					DATETIME		NOT NULL,
observacao					VARCHAR(255)	NOT NULL,
PRIMARY KEY (paciente_num_beneficiario, medico_codigo, data_hora),
FOREIGN KEY (paciente_num_beneficiario)
REFERENCES paciente(num_beneficiario),
FOREIGN KEY (medico_codigo)
REFERENCES medico(codigo)
);

INSERT INTO especialidade
VALUES (1, 'Otorrinolaringologista');

INSERT INTO especialidade
VALUES (2, 'Urologista');

INSERT INTO especialidade
VALUES (3, 'Geriatra');

INSERT INTO especialidade
VALUES (4, 'Pediatra');

INSERT INTO paciente VALUES
(99901, 'Washington Silva', 'R. Anhaia', 150, '02345000', 'Casa', '922229999');

INSERT INTO paciente VALUES
(99902, 'Luis Ricardo', 'R. Voluntários da Pátria', 2251, '03254010', 'Bloco B. Apto 25', '923450987');

INSERT INTO paciente VALUES
(99903, 'Maria Elisa', 'Av. Aguia de Haia', 1188, '06987020', 'Apto 1208', '912348765');

INSERT INTO paciente VALUES
(99904, 'José Araujo', 'R. XV de Novembro', 18, '03678000', 'Casa', '945674312');

INSERT INTO paciente VALUES
(99905, 'Joana Paula', 'R. 7 de Abril', 97, '01214000', 'Conjunto 3 - Apto 801', '912095674');

INSERT INTO medico VALUES
(100001, 'Ana Paula', 'R. 7 de Setembro', 256, '03698000', 'Casa', '915689456', 1);

INSERT INTO medico VALUES
(100002, 'Maria Aparecida', 'Av. Brasil', 32, '02145070', 'Casa', '923235454', 1);

INSERT INTO medico VALUES
(100003, 'Lucas Borges', 'Av. Bras Leme', 876, '02122000', 'Apto 504', '963698585', 2);

INSERT INTO medico VALUES
(100004, 'Gabriel Oliveira', 'Av. Dom Helder Camara', 350, '03145000', 'Apto 602', '93245874', 3);

INSERT INTO consulta VALUES
(99901, 100002, '2021-09-04 13:20:00', 'Infecção Urina');

INSERT INTO consulta VALUES
(99902, 100003, '2021-09-04 13:15:00', 'Gripe');

INSERT INTO consulta VALUES
(99901, 100001, '2021-09-04 12:30:00', 'Infecção Garganta');

ALTER TABLE medico
ADD dia_semana_atendimento VARCHAR(255) NULL;


select * from paciente;
select * from especialidade;
select * from consulta; 
select * from medico;
 
 
    
    
    
    
    
    
    
    
    
    
    
    

