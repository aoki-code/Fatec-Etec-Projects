create database exercicio_locadora_dvd
go
use exercicio_locadora_dvd
go
drop database exercicio_locadora_dvd

create database exercicio_locadora_dvd
go
use exercicio_locadora_dvd

create table filme(
id int not null,
titulo varchar(80) not null,
ano int check(ano < 2021) null
primary key (id)
)

drop table filme

create table filme(
id int not null,
titulo varchar(80) not null,
ano int check(ano < 2021) null
primary key (id)
)

create table estrela(
id int not null,
nome varchar(50) not null,
nome_real varchar(50) null
primary key (id)
)

drop table estrela

create table estrela(
id int not null,
nome varchar(50) not null,
nome_real varchar(50) null
primary key (id)
)

create table cliente(
num_cadastro int not null,
nome varchar(70) not null,
logradouro varchar(150) not null,
num int check(num > 0) not null,
cep char(8) check(len(cep) = 8) null
primary key (num_cadastro)
)

drop table cliente

create table cliente(
num_cadastro int not null,
nome varchar(70) not null,
logradouro varchar(150) not null,
num int check(num > 0) not null,
cep char(8) check(len(cep) = 8) null
primary key (num_cadastro)
)

create table dvd(
num int not null,
data_fabricaçao datetime check (data_fabricaçao < getdate()) not null,
filme_id int not null
primary key (num)
foreign key (filme_id) references filme(id)
)

drop table dvd

create table dvd(
num int not null,
data_fabricaçao datetime check (data_fabricaçao < getdate()) not null,
filme_id int not null
primary key (num)
foreign key (filme_id) references filme(id)
)

create table filme_estrela(
filme_id int not null,
estrela_id int not null,
primary key (filme_id, estrela_id)
foreign key (filme_id) references filme(id),
foreign key (estrela_id) references estrela(id)
)

drop table filme_estrela

create table filme_estrela(
filme_id int not null,
estrela_id int not null
primary key (filme_id, estrela_id)
foreign key (filme_id) references filme(id),
foreign key (estrela_id) references estrela(id)
)

create table locaçao(
dvd_num int not null,
cliente_num_cadastro int not null,
data_locaçao datetime default(getdate()) not null,
data_devoluçao datetime check(data_locaçao < data_devoluçao) not null,
valor decimal(7,2) check (valor > 0) not null
primary key(dvd_num, cliente_num_cadastro, data_devoluçao)
foreign key(dvd_num) references dvd(num),
foreign key(cliente_num_cadastro) references cliente(num_cadastro)
)

insert into filme (id, titulo, ano) values (1001, 'Whiplash', 2015)
insert into filme (id, titulo, ano) values (1002, 'Birdman', 2015)
insert into filme (id, titulo, ano) values (1003, 'Interestelar', 2014)
insert into filme (id, titulo, ano) values (1004, 'A culpa é das estrelas', 2014)
insert into filme (id, titulo, ano) values (1005, 'Alexandre e o dia terrível, horrível, espantoso e horroroso', 2014)
insert into filme (id, titulo, ano) values (1006, 'Sing', 2016)

insert into estrela (id, nome, nome_real) values (9901, 'Michael Keaton', 'Michael John Douglas')
insert into estrela (id, nome, nome_real) values (9902, 'Emma Stone', 'Emily Jean Stone')
insert into estrela (id, nome, nome_real) values (9903, 'Milles Teller', null)
insert into estrela (id, nome, nome_real) values (9904, 'Steve Carell', 'Steve Jonh Carell')
insert into estrela (id, nome, nome_real) values (9905, 'Jennifer Garner', 'Jennifer Anne Garner')

insert into dvd (num, data_fabricaçao, filme_id) values (10001, '2020-12-02', 1001)
insert into dvd (num, data_fabricaçao, filme_id) values (10002, '2019-10-18', 1002)
insert into dvd (num, data_fabricaçao, filme_id) values (10003, '2020-04-03', 1003)
insert into dvd (num, data_fabricaçao, filme_id) values (10004, '2020-12-02', 1001)
insert into dvd (num, data_fabricaçao, filme_id) values (10005, '2019-10-18', 1004)
insert into dvd (num, data_fabricaçao, filme_id) values (10006, '2020-04-03', 1002)
insert into dvd (num, data_fabricaçao, filme_id) values (10007, '2020-12-02', 1005)
insert into dvd (num, data_fabricaçao, filme_id) values (10008, '2019-10-18', 1002)
insert into dvd (num, data_fabricaçao, filme_id) values (10009, '2020-04-03', 1003)

insert filme_estrela (filme_id, estrela_id) values (1002, 9901)
insert filme_estrela (filme_id, estrela_id) values (1002, 9902)
insert filme_estrela (filme_id, estrela_id) values (1001, 9903)
insert filme_estrela (filme_id, estrela_id) values (1005, 9904)
insert filme_estrela (filme_id, estrela_id) values (1005, 9905)

insert into cliente(num_cadastro, nome, logradouro, num, cep) values (5501, 'Matilde Luz', 'Rua Síria', 150, 03086040)
insert into cliente(num_cadastro, nome, logradouro, num, cep) values (5502, 'Carlos Caarreiro', 'Rua Bartolomeu Aires', 1250, 04419110)
insert into cliente(num_cadastro, nome, logradouro, num, cep) values (5503, 'Daniel Ramalho', 'Rua Itajuiba', 169, null)
insert into cliente(num_cadastro, nome, logradouro, num, cep) values (5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, null)
insert into cliente(num_cadastro, nome, logradouro, num, cep) values (5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, 02917110)

insert into locaçao (dvd_num, cliente_num_cadastro, data_locaçao, data_devoluçao, valor) values (10001, 5502, '2021-02-18', '2021-02-21', 3.50)
insert into locaçao (dvd_num, cliente_num_cadastro, data_locaçao, data_devoluçao, valor) values (10009, 5502, '2021-02-18', '2021-02-21', 3.50)
insert into locaçao (dvd_num, cliente_num_cadastro, data_locaçao, data_devoluçao, valor) values (10002, 5503, '2021-02-18', '2021-02-19', 3.50)
insert into locaçao (dvd_num, cliente_num_cadastro, data_locaçao, data_devoluçao, valor) values (10002, 5505, '2021-02-20', '2021-02-23', 3.00)
insert into locaçao (dvd_num, cliente_num_cadastro, data_locaçao, data_devoluçao, valor) values (10004, 5505, '2021-02-20', '2021-02-23', 3.00)
insert into locaçao (dvd_num, cliente_num_cadastro, data_locaçao, data_devoluçao, valor) values (10005, 5505, '2021-02-20', '2021-02-23', 3.00)
insert into locaçao (dvd_num, cliente_num_cadastro, data_locaçao, data_devoluçao, valor) values (10001, 5501, '2021-02-24', '2021-02-26', 3.50)
insert into locaçao (dvd_num, cliente_num_cadastro, data_locaçao, data_devoluçao, valor) values (10008, 5501, '2021-02-24', '2021-02-26', 3.50)

update cliente set cep = 08411150 where num_cadastro = 5503
update cliente set cep = 02918190 where num_cadastro = 5504

update locaçao set valor = 3.25 where cliente_num_cadastro = 5502 and data_locaçao = '2021-02-18'
update locaçao set valor = 3.25 where cliente_num_cadastro = 5501 and data_locaçao = '2021-02-24'

update dvd set data_fabricaçao = '2019-07-14' where num = 10005

update estrela set nome_real = 'Miles Alexander Teller' where id = 9903

delete filme where id = 1006

select cl.num_cadastro, cl.nome, fi.id, dvd.data_fabricacao, lo.valor
from cliente cl, filme fi, dvd, locacao lo
where cl.num_cadastro = lo.clientenum_cadastro
	and dvd.filmeid = fi.id
	and dvd.num = lo.dvdnum
	and dvd.data_fabricacao in
	(
		select max(dvd.data_fabricacao)
		from dvd
	)
order by dvd.data_fabricacao

select cl.num_cadastro, cl.nome, convert(varchar(10), lo.data_locacao, 103) as dt_locacao, count(lo.dvdnum) as qtd_dvd_alugado
from cliente cl, locacao lo
where cl.num_cadastro = lo.clientenum_cadastro
group by lo.data_locacao, cl.nome, cl.num_cadastro

select cl.num_cadastro, cl.nome, convert(varchar(10), lo.data_locacao, 103) as dt_locacao, sum(valor) as valor_total
from cliente cl, locacao lo
where cl.num_cadastro = lo.clientenum_cadastro
group by lo.data_locacao, cl.nome, cl.num_cadastro

select cl.num_cadastro, cl.nome, cl.logradouro + ', ' + cast(cl.num as varchar) as endereço, 
	convert(varchar(10), lo.data_locacao, 103) as dt_locaçao
from cliente cl, locacao lo
where cl.num_cadastro = lo.clientenum_cadastro
	and lo.clientenum_cadastro in
		(
			select cl.num_cadastro
			from cliente cl, locacao lo, dvd, filme fi
			where cl.num_cadastro = lo.clientenum_cadastro
				and dvd.num = lo.dvdnum
				and dvd.filmeid = fi.id
			group by cl.num_cadastro, lo.dvdnum
			having sum(dvd.filmeid) >= 2
		)
group by lo.data_locacao, cl.num_cadastro, cl.nome, cl.logradouro, cl.num
