<<<<<<< HEAD
select *
from users u;

insert into users ("name", email, register_date, birth, state_uf) values ('Marcel Figueiredo', 'mrclof@gmail.com', CURRENT_TIMESTAMP, '2004-01-10', 'BA' );
insert into users ("name", email, register_date, birth, state_uf) values ('Diego Maurício', CURRENT_TIMESTAMP, '2024-11-28', '2002-07-30', 'BA' );
insert into users ("name", email, register_date, birth, state_uf) values ('Fabrício Figueiredo', 'fobf@gmail.com', CURRENT_TIMESTAMP, '2010-05-20', 'SP' );
insert into users ("name", email, register_date, birth, state_uf) values ('Jean Almeida', 'jalgmail.com', CURRENT_TIMESTAMP, '2000-11-10', 'RS' );
insert into users ("name", email, register_date, birth, state_uf) values ('Ronaldinho Gaúcho', 'magogmail.com', CURRENT_TIMESTAMP, '2001-09-15', 'RS' );


select *
from products
order by id;

insert into products ("name", price, category, quantity) values ('ps5', 5000, 'eletronicos', 100);
insert into products ("name", price, category, quantity) values ('camisa bonita', 10, 'camisas', 200);
insert into products ("name", price, category, quantity) values ('camisa normal', 7, 'camisas', 500);
insert into products ("name", price, category, quantity) values ('camisa bem bonita', 25, 'camisas', 250);
insert into products ("name", price, category, quantity) values ('processador i9', 2000, 'eletronicos', 150);


select *
from status;

insert into status (description) values ('waiting_payment');
insert into status (description) values ('paid');
insert into status (description) values ('delivering');
insert into status (description) values ('deliveredt');
insert into status (description) values ('canceled');

select *
from orders o;

insert into orders (status_id, quantity) values (2, 100);

insert into orders (status_id, quantity) values (2, 1);

insert into orders (status_id, quantity) values (3, 1);

insert into orders (status_id, quantity) values (3, 10);

insert into orders (status_id, quantity) values (3, 1);

insert into orders (status_id, quantity) values (5, 8);

select *
from orders_products op; 

insert into orders_products (order_id, product_id, user_id, order_date) values (1, 2, 1, CURRENT_TIMESTAMP);

insert into orders_products (order_id, product_id, user_id, order_date) values (1, 5, 1, CURRENT_TIMESTAMP);

insert into orders_products (order_id, product_id, user_id, order_date) values (2, 1, 1, CURRENT_TIMESTAMP);

insert into orders_products (order_id, product_id, user_id, order_date) values (3, 4, 2, CURRENT_TIMESTAMP);

insert into orders_products (order_id, product_id, user_id, order_date) values (3, 1, 2, CURRENT_TIMESTAMP);

insert into orders_products (order_id, product_id, user_id, order_date) values (4, 4, 4, CURRENT_TIMESTAMP);


--------- Nível Básico
-------- Questão 01 
select 
	p."name" 
from products p 
where p.price > 1000;
------------------------------------------
-------- Questão 02
select 
	u.state_uf,
	count(u.state_uf) 
from users u 
group by u.state_uf;
-------------------------------------------------

--------- Nível Intermediário
-------- Questão 01 
select 
--*
	u."name", 
	count( u.id) as qt_bougth
from orders_products op 
inner join orders o on o.id = op.order_id
inner join users u on u.id = op.user_id 
group by u."name" 
having count( u.id) > 1
order by qt_bougth desc;
--------------------------------------------------
-------- Questão 02
select 
from 
--------------------------------------------------
-------- Questão 03
select 
	p.id,
	p."name" 
from products p
where not exists (select 1 from orders o where o.product_id = p.id); -- select 1-> pode ser qualquer valor, inclusive p.id 
--------------------------------------------------

--------- Nível Avançado
-------- Questão 01 
select 
	p."name", 
	sum(p.quantity) as sold_qt
from orders o, products p
where o.product_id = p.id 
group by distinct (o.product_id), p."name"
order by sum(o.quantity) desc; 
--------------------------------------------------
-------- Questão 02
select 
	u."name",
	sum(o.price_unit * o.quantity)/count(distinct(o.id)) as avg_per_ticket 
from orders o, users u 
where o.user_id = u.id 
group by u."name"
order by avg_per_ticket desc;
--------------------------------------------------
-------- Questão 03
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS current_month,
        SUM(o.price_unit * o.quantity) AS monthly_total_value
    FROM
        orders o
    GROUP BY
        current_month
    ORDER BY
        current_month
)
SELECT
    current_month,
    monthly_total_value,
    LAG(monthly_total_value, 1) OVER (ORDER BY current_month) AS previous_month_total_value,
    (monthly_total_value - LAG(monthly_total_value, 1) OVER (ORDER BY current_month)) AS difference
FROM
    monthly_sales;

=======
select *
from users u;

select insert_users('Marcel Figueiredo', 'mrclof@gmail.com', '2024-11-28', '2004-01-10', 'BA' );
select insert_users('Diego Maurício', 'dmjes@gmail.com', '2024-11-28', '2002-07-30', 'BA' );
select insert_users('Fabrício Figueiredo', 'fobf@gmail.com', '2024-11-28', '2010-05-20', 'SP' );
select insert_users('Jean Almeida', 'jalgmail.com', '2024-11-28', '2000-11-10', 'RS' );
select insert_users('Jair Bolsonaro', 'mito@gmail.com', '2024-11-28', '1990-07-01', 'SP' );
select insert_users('Ronaldinho Gaúcho', 'magogmail.com', '2024-05-28', '2001-09-15', 'RS' );


select *
from products
order by id;

select insert_products('ps5', 5000, 'eletronicos', 100);
select insert_products('camisa bonita', 10, 'camisas', 200);
select insert_products('camisa normal', 7, 'camisas', 500);
select insert_products('camisa bem bonita', 25, 'camisas', 250);
select insert_products('processador i9', 2000, 'eletronicos', 150);

select *
from orders o;


--insert_orders(order_id integer, quantity_order integer, shipping varchar (15), price_unit numeric (10, 2), 
--user_id integer, product_id integer, order_date date); 
select insert_orders(1, 2, 'delivering', 4500, 1, 1, '2024-11-29');

select insert_orders(2, 2, 'delivering', 4500, 2, 1, '2024-11-29');

select insert_orders(3, 1, 'delivering', 5000, 5, 1, '2024-11-29');

select insert_orders(3, 10, 'delivering', 2000, 5, 5, '2024-11-29');

select insert_orders(4, 20, 'delivering', 9, 5, 3, '2024-11-29');

select insert_orders(5, 1, 'delivering', 2000, 6, 5, '2024-10-29');




--------- Nível Básico
-------- Questão 01 
select 
	p."name" 
from products p 
where p.price > 1000;
------------------------------------------
-------- Questão 02
select 
	u.state_uf,
	count(u.state_uf) 
from users u 
group by u.state_uf;
-------------------------------------------------

--------- Nível Intermediário
-------- Questão 01 
select 
	u."name" ,
	count(distinct(o.id))
from orders o, users u 
where o.user_id = u.id 
group by u."name"  
having count(distinct (o.id)) > 1; 
--------------------------------------------------
-------- Questão 02
select 
	o.id,
	sum(o.price_unit * o.quantity)
from orders o, products p 
where o.product_id = p.id 
group by distinct (o.id)
order by o.id;
--------------------------------------------------
-------- Questão 03
select 
	p.id,
	p."name" 
from products p
where not exists (select 1 from orders o where o.product_id = p.id); -- select 1-> pode ser qualquer valor, inclusive p.id 
--------------------------------------------------

--------- Nível Avançado
-------- Questão 01 
select 
	p."name", 
	sum(o.quantity) as sold_qt
from orders o, products p
where o.product_id = p.id 
group by distinct (o.product_id), p."name"
order by sum(o.quantity) desc; 
--------------------------------------------------
-------- Questão 02
select 
	u."name",
	sum(o.price_unit * o.quantity)/count(distinct(o.id)) as avg_per_ticket 
from orders o, users u 
where o.user_id = u.id 
group by u."name"
order by avg_per_ticket desc;
--------------------------------------------------
-------- Questão 03
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS current_month,
        SUM(o.price_unit * o.quantity) AS monthly_total_value
    FROM
        orders o
    GROUP BY
        current_month
    ORDER BY
        current_month
)
SELECT
    current_month,
    monthly_total_value,
    LAG(monthly_total_value, 1) OVER (ORDER BY current_month) AS previous_month_total_value,
    (monthly_total_value - LAG(monthly_total_value, 1) OVER (ORDER BY current_month)) AS difference
FROM
    monthly_sales;

>>>>>>> 90a1bc2479aa8d16cc7a5fa5f186461d7296c8e1
