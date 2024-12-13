drop table orders;
drop table products;
drop table users;

------- CREATING TABLES

create table users (
id SERIAL primary KEY,
name VARCHAR(100) not null,
email VARCHAR(100) unique not null,
birth DATE 
);

create table products (
	id serial primary key,
	price numeric(10, 2) not null,
	weight_kg numeric(5, 2) not null,
	volume_m3 numeric(5,2),
	description VARCHAR(100) not null
);

create table orders(
	id serial primary key,
	user_id integer,	
	foreign key (user_id) references "users"(id),
	product_id integer,
	foreign key (product_id) references products (id),
	date DATE not null,
	quantity integer not null,
	price numeric(10, 2)
	);

---------Functions

create or replace function age_by_id (id_usuario integer) returns INTEGER as $$
declare 
	nascimento DATE;
	idade INTEGER;

begin
	select 
	birth into nascimento
	from "users"
	where id = id_usuario;

	-- Calculando idade
	idade := extract(year from age(nascimento));

	return idade;
end;
$$ language plpgsql;


create or replace function pessoa_mais_nova() returns varchar(10) as $$
declare
	mais_novo varchar(10); 
begin 
	select 
	name into mais_novo
	from users
	where birth = (select max(birth) from users);
	
	return mais_novo;
end;
$$ language plpgsql;

create or replace function pessoa_mais_velha() returns varchar(10) as $$
declare
	mais_velho varchar(10); 
begin 
	select 
	name into mais_velho
	from users
	where birth = (select min(birth) from users);
	
	return mais_velho;
end;
$$ language plpgsql;

create or replace function media_de_idade() returns real as $$
declare 
	media real; 
begin 
	select 
	avg( extract (year from age (users.birth)) ) into media
	from users;

	return media;
end;
$$ language plpgsql;

------------------------------------
ALTER TABLE "user" 
RENAME COLUMN id TO user_id;

ALTER TABLE "user" 
RENAME COLUMN nome TO user_name;

alter table "user" 
rename column data_de_nascimento to user_bith;

----------------------------------------

