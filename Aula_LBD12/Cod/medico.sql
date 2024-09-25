CREATE DATABASE medico

USE medico

CREATE TABLE medico (
idmedico		INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL
PRIMARY KEY(idmedico)
)

CREATE TABLE paciente (
idpaciente		INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL,
data_nasc		DATE			NOT NULL
PRIMARY KEY(idpaciente)
)

CREATE TABLE medico_paciente (
medicoidmedico			INT				NOT NULL,
pacienteidpaciente		INT				NOT NULL,
datahora				DATETIME		NOT NULL,
cid						INT				NOT NULL,
tratamento				VARCHAR(50)		NOT NULL
PRIMARY KEY(medicoidmedico, pacienteidpaciente, datahora)
FOREIGN KEY(medicoidmedico) REFERENCES medico(idmedico),
FOREIGN KEY(pacienteidpaciente) REFERENCES paciente(idpaciente)
)

CREATE TABLE especialidade (
idespecialidade			INT				NOT NULL,
especialidade			VARCHAR(50)		NOT NULL
PRIMARY KEY(idespecialidade)
)

CREATE TABLE medico_especialidade (
medicoidmedico					INT			NOT NULL,
especialidadeidespecialidade	INT			NOT NULL
PRIMARY KEY(medicoidmedico, especialidadeidespecialidade)
FOREIGN KEY(medicoidmedico) REFERENCES medico(idmedico),
FOREIGN KEY(especialidadeidespecialidade) REFERENCES especialidade(idespecialidade)
)

CREATE PROCEDURE teste @medico INT, @paciente INT, @cid INT
AS
BEGIN
    DECLARE @idMedico INT = (SELECT idmedico FROM medico WHERE idmedico = @medico)
    DECLARE @idPaciente INT = (SELECT idpaciente FROM paciente WHERE idpaciente = @paciente)
    DECLARE @tratamento VARCHAR(100) = (SELECT e.especialidade
                                        FROM medico m
                                        INNER JOIN medico_especialidade me ON me.medicoidmedico = m.idmedico
                                        INNER JOIN especialidade e ON e.idespecialidade = me.especialidadeidespecialidade
                                        WHERE m.idmedico = @idMedico)
    INSERT INTO medico_paciente VALUES (@idMedico, @idPaciente, CURRENT_TIMESTAMP, @cid, @tratamento)
END

CREATE PROCEDURE especs
AS
BEGIN
    DECLARE @gera INT = (SELECT COUNT(*) - 1 FROM especialidade)
    DECLARE @cont INT = 1

    WHILE @cont <= (SELECT COUNT(*) FROM medico)
    BEGIN
        DECLARE @random INT = (CAST(RAND() * @gera + 1 AS INT))
        INSERT INTO medico_especialidade VALUES (@cont, @random)
        SET @cont = @cont + 1
    END
END