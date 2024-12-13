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

