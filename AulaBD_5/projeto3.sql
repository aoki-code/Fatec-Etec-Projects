create database exercicio_projeto
go
use exercicio_projeto
go

create table users(
id int identity (1, 1) not null,
name varchar(45) not null,
username varchar (45) unique not null,
password varchar(45) default('123mudar') not null,
email varchar(45) not null
primary key (id)
)

create table project(
id int identity (10001,1) not null,
name varchar(45) not null,
description varchar(45) null,
date datetime check(date > 2014-09-01) not null,
primary key(id)
)

create table users_has_projects(
users_id int not null,
project_id int not null
primary key (users_id, project_id)
foreign key (users_id) references users(id),
foreign key (project_id) references project(id)
)

alter table users
alter column username varchar(10) not null

alter table users
alter column password varchar(8) not null

alter table project
alter column date date not null

insert into users (name, username, password, email) values ('Maria','Rh_maria', '123mudar', 'maria@empresa.com')
insert into users (name, username, password, email) values ('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com')
insert into users (name, username, password, email) values ('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com')
insert into users (name, username, password, email) values ('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com')
insert into users (name, username, password, email) values ('Aparecido', 'Rh_apareci', '55@!Cido', 'aparecido@empresa.com')
insert into users (name, username, password, email) values ('Joao', 'Ti_joao', '123mudar', 'joao@empresa.com')

insert into project (name, description, date) values ('Re-folha', 'Refatoração das folhas', '2014-09-05')
insert into project (name, description, date) values ('Manutenção PCs', 'Manutenção PCs', '2014-09-06')
insert into project (name, description, date) values ('Auditoria', null, '2014-09-07')
insert into project (name, description, date) values ('Atualização de Sistemas', 'Modificação de Sistemas Operacionais nos PC's', '2014-09-12')

insert into users_has_projects (users_id, project_id) values (1, 10001)
insert into users_has_projects (users_id, project_id) values (5, 10001)
insert into users_has_projects (users_id, project_id) values (3, 10003)
insert into users_has_projects (users_id, project_id) values (4, 10002)
insert into users_has_projects (users_id, project_id) values (2, 10002)

update project set date = '2014-12-09' where name = 'Manutenção de PCs'
update project set date = '2014-07-09' where name = 'Auditoria'
update project set date = '2014-05-09' where name = 'Re-folha'
update users set username = 'Rh_cido' where name = 'Aparecido'
update users set password = '888@*' where username = 'Rh_maria' and password = '123mudar'

delete users_has_projects where users_id = 2

select count(p.name) qty_projects_no_users
from project p left outer join users_has_projects up
on p.id = up.project_id
where up.project_id is null
group by p.name

select p.id, p.name, count(up.users_id) as qty_users_project
from project p, users_has_projects up, users u
where p.id = up.project_id
	and u.id = up.users_id
group by p.id, p.name
order by p.name asc

