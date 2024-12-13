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

