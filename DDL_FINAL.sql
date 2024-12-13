<<<<<<< HEAD
drop table orders_products;
drop table orders;
drop table users;
drop table products;
drop table status;


----------Tables--------------------------------------
create table users(
id serial primary key,
name varchar(100) not null,
email varchar(100) unique not null,
register_date timestamp not null,
birth date not null,
state_uf varchar(2) not null
);

create table products(
id serial primary key,
name varchar(100) not null,
price numeric(10, 2) not null,
category varchar(20) not null,
quantity integer not null
);

create table status (
id serial primary key,
description varchar(100) not null
);

create table orders(
id serial primary key,
status_id integer not null,
quantity integer not null,
foreign key (status_id) references status(id)
);

create table orders_products (
id serial primary key,
order_id integer not null,
product_id integer not null,
user_id integer not null,
order_date timestamp not null,
foreign key (product_id) references products(id),
foreign key (user_id) references users(id)
);

=======
drop table orders;
drop table users;
drop table products;
drop table clientes;

DROP FUNCTION insert_orders(order_id integer, quantity_order integer, shipping varchar (15), price_unit numeric (10, 2), user_id integer, product_id integer, order_date date); 

drop function inserting_orders(id integer, quantity_order INTEGER, shipping VARCHAR(15), price_unit NUMERIC(10, 2), user_id INTEGER, product_id INTEGER); 

drop function insert_products(name varchar(100), price numeric(10, 2), category varchar(20), quantity integer);

drop function insert_users(name varchar(100), email varchar(100), register_date date, birth date, state_uf varchar(2));

drop  function inserir_cliente(nome VARCHAR, email VARCHAR);

----------Tables--------------------------------------
create table users(
id serial primary key,
name varchar(100) not null,
email varchar(100) unique not null,
register_date date not null,
birth date not null,
state_uf varchar(2) not null
);

create table products(
id serial primary key,
name varchar(100) not null,
price numeric(10, 2) not null,
category varchar(20) not null,
quantity integer check (quantity >= 0) not null
);

create table orders(
id integer not null,
quantity integer check (quantity >= 0) not null,
shipping varchar (15) not null,
price_unit numeric (10, 2),
user_id integer,
product_id integer,
order_date date not null, --- o termo order teve que estar presente por date ser uma palavra-chave.
foreign key (user_id) references users(id),
foreign key (product_id) references products(id)
);

------------- Functions 
create or replace function insert_users(name varchar(100), email varchar(100), register_date date, birth date, state_uf varchar(2))
returns void as $$
begin 
	insert into users (name, email, register_date, birth, state_uf)
	values(name, email, register_date, birth, state_uf);
end;
$$ language plpgsql;


create or replace function insert_products(name varchar(100), price numeric(10, 2), category varchar(20), quantity integer)
returns void as $$
begin 
	insert into products (name, price, category, quantity)
	values(name, price, category, quantity);
end;
$$ language plpgsql;






create or replace function insert_orders(order_id integer, quantity_order integer, shipping varchar (15), 
price_unit numeric (10, 2), user_id integer, order_product_id integer, order_date date
)
returns void as $$

begin 

	-- Verificar se o id está disponível
    IF (SELECT o.user_id FROM orders o WHERE o.id = order_id LIMIT 1) <> user_id THEN --- FOI USADO O LIMIT 1 PARA NÃO DAR ERRO DE MAIS DE UMA LINHA RETORNADA
        RAISE EXCEPTION 'ID indisponível pois já está sendo usado por outro usuário de ID: %', (SELECT o.user_id FROM orders o WHERE o.id = order_id);
    END IF;

	-- Verificar se a quantidade disponível é suficiente antes de atualizar
    IF (SELECT p.quantity FROM products p WHERE p.id = order_product_id) < quantity_order THEN
        RAISE EXCEPTION 'Quantidade insuficiente no estoque para o produto ID %', product_id;
    END IF;

	--- Taking quantity	
	update products
	set quantity = quantity - quantity_order
	where products.id = order_product_id;

	--- Inserting the new order
	-- Verificar se o id de compra já existe e existe um id de produto
    IF ((SELECT o.id FROM orders o WHERE o.id = order_id LIMIT 1) = order_id) and ((SELECT o.product_id FROM orders o WHERE o.product_id = order_product_id LIMIT 1) = order_product_id) THEN
		update orders
		set quantity = quantity + quantity_order
		where product_id = order_product_id;
    else
		-- Criar novo id de order adicionando as novas informações
		insert into orders values(order_id, quantity_order, shipping, price_unit, user_id, order_product_id, order_date);
    END IF;
end;
$$ language plpgsql;


CREATE OR REPLACE FUNCTION inserting_orders(
	id integer,
    quantity_order INTEGER, 
    shipping VARCHAR(15), 
    price_unit NUMERIC(10, 2), 
    user_id INTEGER, 
    product_id INTEGER
) 
RETURNS VOID AS $$
BEGIN 
    -- Verificar se a quantidade disponível é suficiente antes de atualizar
    IF (SELECT p.quantity FROM products p WHERE p.id = product_id) < quantity_order THEN
        RAISE EXCEPTION 'Quantidade insuficiente no estoque para o produto ID %', product_id;
    END IF;

    -- Atualizar a quantidade no estoque
    UPDATE products
    SET quantity = quantity - quantity_order
    WHERE products.id = product_id;

    -- Inserir o novo pedido na tabela 'orders'
    INSERT INTO orders (id, quantity, shipping, price_unit, user_id, product_id)
    VALUES (id, quantity_order, shipping, price_unit, user_id, product_id);
END;
$$ LANGUAGE plpgsql;





-----------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE OR REPLACE FUNCTION inserir_cliente(nome VARCHAR, email VARCHAR)
RETURNS VOID AS $$
BEGIN
    INSERT INTO clientes (nome, email)
    VALUES (nome, email);
END;
$$ LANGUAGE plpgsql;



select inserir_cliente('Marcel', 'mrclof')

select *
from clientes;

select inserir_cliente('Diego', 'dg');


INSERT INTO clientes (id, nome, email)
VALUES (3, 'nome', 'email');

select inserir_cliente('Fabrício', 'fa');




>>>>>>> 90a1bc2479aa8d16cc7a5fa5f186461d7296c8e1
