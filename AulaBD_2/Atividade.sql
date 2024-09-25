CREATE DATABASE Atividade;

USE Atividade;

CREATE TABLE projetos (
id 					INT 			IDENTITY(10001, 1) 				NOT NULL,
nome 				VARCHAR(45)	   						 			NOT NULL,
descricao 			VARCHAR(45)	   						 				NULL,
data_A 				DATE			CHECK(data_A <  '2014-09-01')	NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE usuarios (
id	 				INT			 	IDENTITY(1, 1)			NOT NULL,
nome 				VARCHAR(45)	    						NOT NULL,
username 			VARCHAR(45)	    UNIQUE					NOT NULL,
senha 				VARCHAR(45)		DEFAULT('123mudar') 		NULL,
email				VARCHAR(45)								NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE usuarios_projetos (
usuarios_id	 				INT			 	NOT NULL,
projetos_id	 				INT			 	NOT NULL,
PRIMARY KEY (usuarios_id, projetos_id),
FOREIGN KEY (usuarios_id)
REFERENCES usuarios(id),
FOREIGN KEY (projetos_id)
REFERENCES projetos(id)
);

ALTER TABLE usuarios ALTER COLUMN username VARCHAR(10);
ALTER TABLE usuarios ALTER COLUMN senha VARCHAR(8);

INSERT INTO usuarios VALUES
(1, 'Maria', 'Rh_maria', NULL, 'maria@empresa.com'),
(2, 'Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
(3, 'Ana', 'Rh_ana', NULL, 'ana@empresa.com'),
(4, 'Clara', 'Ti_clara', NULL, 'clara@empresa.com'),
(5, 'Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com');

INSERT INTO projetos VALUES
('Re-folha', 'Refatoração das Folhas', '2014-09-05'),
('Manutenção PC ́s', 'Manutenção PC ́s', '2014-09-06'),
('Auditoria', NULL, '2014-09-07');

INSERT INTO usuarios_projetos VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002);

UPDATE projetos SET data_A = '2014-09-12'
WHERE id = 10002;

UPDATE usuarios SET username = 'Rh_cido'
WHERE nome = 'Aparecido';

UPDATE usuarios SET senha = '888@'
WHERE username = 'Rh_maria';

DELETE FROM usuarios_projetos WHERE usuarios_id=2;




















