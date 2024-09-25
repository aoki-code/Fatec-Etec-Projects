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

select id, name, email, username, 
case when password <> '123mudar' 
then '********'
else password
end as passwd from users

select id, name, description, date, dateadd(day, 15, date) as final_date 
from project where id = 10001

select name, email 
from users where id = 
(select users_id from users_has_projects 
where project_id = 10003)

select name, description, convert(char(10), date, 103) as start_date, '16/09/2014' as final_date, 
datediff(day, date, '2014-09-16') * 79.85 as custo_total 
from project where id = 10002

select u.id, u.name, u.email, p.id, p.name, p.description, p.date
from users u, project p, users_has_projects up
where u.id = up.users_id
	and p.id = up.project_id
	and p.name like 'Re-folha'

select p.name 
from project p left outer join users_has_projects up
on p.id = up.project_id
where p.id is null

select u.name
from users u left outer join users_has_projects up
on u.id = up.users_id
where up.users_id is null