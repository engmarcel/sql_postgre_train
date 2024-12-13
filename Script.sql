create table users (
id serial primary key,
name varchar(100) not null,
regist_date date not null,
birth date not null,
email varchar(100) not null,
state varchar(2) not null
);