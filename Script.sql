create table "user_" (
id SERIAL primary KEY,
nome VARCHAR(100) not null,
email VARCHAR(100) unique not null,
DATA_DE_NASCIMENTO DATE 
);


select * 
from "user" u 
insert into orders (id, nome, email, idade)
values ('229', 'Marcel', 'mrclof3@gmail.com', '31');

delete from "user" 
where id = 229;

update "user" 
set nome = 'Diego', email = 'dmjes@gmail.com', idade = '35'
where id = 229;


ALTER TABLE public.orders RENAME TO "user";


ALTER TABLE public."user" RENAME column idade to data_de_nascimento;

select *
from "user" u;

