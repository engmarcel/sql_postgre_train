
select *
from "user" u;

insert into "user" (id = '225', nome = 'Diego', email = 'dmjes@gmail.com', data_de_nascimento = '2004-10-01');
--values ('225', 'Diego', 'dmjes@gmail.com', '2004-10-01');

insert into "user" (id, nome, email, data_de_nascimento)
values (226, 'Marcel', 'mrclof3@gmail.com', '2006-05-02')

insert into "user" (id, nome, email, data_de_nascimento)
values (320, 'Fabrício', 'fabrious@gmail.com', '20010-03-15');



update "user" 
set data_de_nascimento = '2010-03-15'
where id = 320

select age_by_id(320)

select 
	avg(extract (year from age(u.data_de_nascimento)))
from "user" u 

select 
	u.id,
	u.nome,
	u.data_de_nascimento
from "user" u
where u.data_de_nascimento = (select min(data_de_nascimento) from "user") or
		u.data_de_nascimento = (select max(data_de_nascimento) from "user");


delete from "user" 
where id = 320;

insert into "user" (id, nome, email, data_de_nascimento)
values ('320', 'Jean', 'jcmnei@gmail.com', '2000-04-28')

select 
	avg(extract (year from age(u.user_bith)))
from "user" u;

select 
	u.user_id,
	u.user_name ,
	u.email ,
	u.user_bith 
from "user" u 
where u.user_bith = (select min(user_bith) from "user") or
		u.user_bith =(select max(user_bith) from "user");
		
select 
	u.nome 
from "user" u 
where data_de_nascimento = (select max(data_de_nascimento) from "user" );

select 
	u.nome 
from "user" u
where data_de_nascimento = (select min(data_de_nascimento) from "user" );



select *
from "user" u;
