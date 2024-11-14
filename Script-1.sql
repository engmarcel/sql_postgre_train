create table "user" (
id SERIAL primary KEY,
nome VARCHAR(100) not null,
email VARCHAR(100) unique not null,
data_de_nascimento DATE 
);


select *
from "user" u;

insert into "user" (id, nome, email, data_de_nascimento)
values ('225', 'Diego', 'dmjes@gmail.com', '2004-10-01');

insert into "user" (id, nome, email, data_de_nascimento)
values (226, 'Marcel', 'mrclof3@gmail.com', '2006-05-02')

insert into "user" (id, nome, email, data_de_nascimento)
values (320, 'Fabrício', 'fabrious@gmail.com', '20010-03-15');

create or replace function age_by_id (id_usuario integer) returns INTEGER as $$
declare 
	nascimento DATE;
	idade INTEGER;

begin
	select 
	data_de_nascimento into nascimento
	from "user"
	where id = id_usuario;

	-- Calculando idade
	idade := extract(year from age(nascimento));

	return idade;
end;
$$ language plpgsql;

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
	avg(extract (year from age(data_de_nascimento)))
from "user" u 

select 
	u.id,
	u.nome,
	u.email,
	u.data_de_nascimento 
from "user" u 
where u.data_de_nascimento = (select min(data_de_nascimento) from "user") or
		u.data_de_nascimento =(select max(data_de_nascimento) from "user");
		
select 
	u.nome 
from "user" u 
where data_de_nascimento = (select max(data_de_nascimento) from "user" );

select 
	u.nome 
from "user" u
where data_de_nascimento = (select min(data_de_nascimento) from "user" );


ALTER TABLE "user" 
RENAME COLUMN id TO user_id;

ALTER TABLE "user" 
RENAME COLUMN nome TO user_name;

alter table "user" 
rename column data_de_nascimento to user_bith;

create table product (
	product_id serial primary key,
	price numeric(10, 2) not null,
	product_weight_kg numeric(5, 2) not null,
	product_volume_m3 numeric(5,2)
);

create table orders(
	order_id serial primary key,
	user_id integer,	
	foreign key (user_id) references "user"(user_id),
	product_id integer,
	foreign key (product_id) references product (product_id),
	order_date DATE not null,
	quantity integer not null,
	price numeric(10, 2)
	);


select *
from "user" u;
