--drop table "user";
--drop table orders;
--drop table product;

create table "user" (
id SERIAL primary KEY,
nome VARCHAR(100) not null,
email VARCHAR(100) unique not null,
data_de_nascimento DATE 
);

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