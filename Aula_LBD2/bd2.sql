CREATE DATABASE aula2

CREATE TABLE Motorista(
	codigo int,
	nome varchar(255),
	naturalidade varchar(20),
	PRIMARY KEY (codigo)
)

CREATE TABLE Onibus(
	placa varchar(8),
	marca varchar(10),
	ano int,
	descricao varchar(15),
	PRIMARY KEY (placa)
)

CREATE TABLE Viagem(
	codigo int,
	onibus varchar(8),
	motorista int,
	horaSaida int,
	horaChegada int,
	partida varchar(20),
	destino varchar(20),
	PRIMARY KEY (codigo),
	FOREIGN KEY (onibus) REFERENCES Onibus(placa),
	FOREIGN KEY (motorista) REFERENCES Motorista(codigo),
	CHECK (horaSaida>=0),
	CHECK (horaChegada>=0)
)


--1) Criar um Union das tabelas Motorista e ônibus, com as colunas ID (Código e Placa) e Nome (Nome e Marca)
SELECT CAST(codigo AS varchar) AS id, nome As nome from Motorista
UNION
SELECT placa AS id, marca AS nome from Onibus

--2) Criar uma View (Chamada v_motorista_onibus) do Union acima
CREATE VIEW v_motorista_onibus
AS
SELECT CAST(codigo AS varchar) AS id, nome As nome from Motorista
UNION
SELECT placa AS id, marca AS nome from Onibus

--3) Criar uma View (Chamada v_descricao_onibus) que mostre o Código da Viagem, o Nome do motorista, a placa do ônibus (Formato XXX-0000), a Marca do ônibus, o Ano do ônibus e a descrição do onibus
CREATE VIEW v_descricao_onibus
AS
SELECT V.codigo, M.nome, V.onibus, O.marca, O.ano, O.descricao
FROM Viagem V, Onibus O, Motorista M
WHERE 
V.onibus = O.placa
AND V.motorista = M.codigo

--4) Criar uma View (Chamada v_descricao_viagem) que mostre o Código da viagem, a placa do ônibus(Formato XXX-0000), a Hora da Saída da viagem (Formato HH:00), a Hora da Chegada da viagem (Formato HH:00), partida e destino
CREATE VIEW v_descricao_viagem
AS 
SELECT codigo, onibus,horaSaida, horaChegada, partida, destino
FROM Viagem