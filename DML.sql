select *
from "users" u;

insert into "users" values ('225', 'Diego', 'dmjes@gmail.com', '2004-10-01');

select 
	u."name",
	u.birth,
	u.id,
	age_by_id(u.id) as age
from users u;

insert into "users" values (226, 'Marcel', 'mrclof3@gmail.com', '2006-05-02');

insert into "users" (id, "name", email, birth) 
values (320, 'Fabrício', 'fabrious@gmail.com', '20010-03-15');


select pessoa_mais_nova();

select pessoa_mais_velha();

update "users" 
set birth = '2010-03-15'
where email = 320;

select age_by_id(320)

select 
	avg(extract (year from age(u.data_de_nascimento)))
from "user" u 


delete from "users" 
where id = 320;

insert into "users" values ('320', 'Jean', 'jcmnei@gmail.com', '2000-04-28');

select 
	avg(extract (year from age(u.birth)))
from "users" u;
		

select *
from orders o ;

select media_de_idade();

insert into "users" ("name", email, birth) 
values ('Fabrício', 'fabrious@gmail.com', '20010-03-15');



select  * 
from users;

