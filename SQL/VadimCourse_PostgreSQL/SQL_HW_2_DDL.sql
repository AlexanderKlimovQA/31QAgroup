
-- Таблица employees

-- 1) Создать таблицу employees
-- - id. serial,  primary key,
-- - employee_name. Varchar(50), not null
-- 2) Наполнить таблицу employee 70 строками.

create table employees(
	id serial primary key,
	employee_name varchar (50) not null
);

insert into employees(employee_name)
values ('Fily'),
	   ('Kily'),
	   ('Bofur'),
	   ('Bombur'),
	   ('Torin'),
	   ('Ori'),
	   ('Nori'),
	   ('Gendalf'),
	   ('Bilbo'),
	   ('Frodo');

select *
from employees


-- Таблица salary

-- 1) Создать таблицу salary
-- - id. Serial  primary key,
-- - monthly_salary. Int, not null
-- 2) Наполнить таблицу salary 15 строками

create table salary2(
id serial primary key,
monthly_salary int not null
);

insert into salary2(monthly_salary)
values (1000),
	   (1100),
	   (1200),
	   (1300),
	   (1400),
	   (1500),
	   (1600),
	   (1700),
	   (1800),
	   (1900),
	   (2000),
	   (2100),
	   (2200),
	   (2300),
	   (2400),
	   (2500);

select *
from salary2


-- Таблица employee_salary

-- 1) Создать таблицу employee_salary
-- - id. Serial  primary key,
-- - employee_id. Int, not null, unique
-- - salary_id. Int, not null
-- 2) Наполнить таблицу employee_salary 40 строками:
-- - в 10 строк из 40 вставить несуществующие employee_id

create table employee_salary(
	id serial primary key,
	employee_id int not null unique,
	salary_id int not null
);

insert into employee_salary(employee_id, salary_id)
values (1, 2),
	   (2, 3),
	   (3, 4),
	   (4, 16),
	   (5, 1),
	   (6, 7),
	   (7, 7),
	   (8, 10),
	   (9, 2),
	   (10, 14),
	   (11, 10),
	   (12, 9),
	   (13, 9),
	   (14, 11),
	   (15, 13),
	   (16, 4),
	   (17, 1),
	   (18, 3),
	   (19, 7),
	   (20, 16),
	   (21, 4),
	   (22, 5),
	   (23, 1),
	   (24, 5),
	   (25, 9),
	   (26, 11),
	   (27, 12),
	   (28, 1),
	   (29, 6),
	   (30, 1),
	   (80, 2),
	   (81, 11),
	   (82, 12),
	   (83, 1),
	   (90, 12),
	   (93, 14),
	   (100, 1),
	   (101, 12),
	   (102, 3),
	   (75, 16),
	   (77, 11),
	   (777, 1),
	   (999, 3);
	   

select *
from employee_salary;


-- Таблица roles

-- 1) Создать таблицу roles
-- - id. Serial  primary key,
-- - role_name. int, not null, unique
-- 2) Поменять тип столба role_name с int на varchar(30)
-- 3) Наполнить таблицу roles 20 строками

create table roles1(
	id serial primary key,
	role_name int not null unique
);

alter table roles1
alter column role_name type varchar (30);

insert into roles1(role_name)
values ('Junior Python developer'),
	   ('Middle Python developer'),
	   ('Senior Python developer'),
	   ('Junior Java developer'),
	   ('Middle Java developer'),
	   ('Senior Java developer'),
	   ('Junior JavaScript developer'),
	   ('Middle JavaScript developer'),
	   ('Senior JavaScript developer'),
	   ('Junior Manual QA engineer'),
	   ('Middle Manual QA engineer'),
	   ('Senior Manual QA engineer'),
	   ('Project Manager'),
	   ('Designer'),
	   ('HR'),
	   ('CEO'),
	   ('Sales manager'),
	   ('Junior Automation QA engineer'),
	   ('Middle Automation QA engineer'),
	   ('Senior Automation QA engineer');

select *
from roles1;


-- Таблица roles_employee

-- 1) Создать таблицу roles_employee
-- - id. Serial  primary key,
-- - employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
-- - role_id. Int, not null (внешний ключ для таблицы roles, поле id)
-- 2) Наполнить таблицу roles_employee 40 строками

create table roles_employee(
	id serial primary key,
	employee_id int not null unique,
	role_id int not null,
	foreign key(employee_id)
		references employees(id),
	foreign key(role_id)
		references roles1(id)
);

insert into roles_employee(employee_id, role_id)
values (1, 2),
	   (2, 3),
	   (3, 4),
	   (4, 16),
	   (5, 1),
	   (6, 7),
	   (7, 17),
	   (8, 10),
	   (9, 2),
	   (10, 14),
	   (11, 10),
	   (12, 19),
	   (13, 9),
	   (14, 11),
	   (15, 13),
	   (16, 4),
	   (17, 1),
	   (18, 3),
	   (19, 18),
	   (20, 16),
	   (21, 4),
	   (22, 5),
	   (23, 1),
	   (24, 5),
	   (25, 9),
	   (26, 11),
	   (27, 12),
	   (28, 1),
	   (29, 6),
	   (30, 1),
	   (31, 2),
	   (32, 11),
	   (33, 12),
	   (34, 1),
	   (35, 18),
	   (36, 14),
	   (37, 1),
	   (38, 20),
	   (39, 3),
	   (40, 16);
	   
update roles_employee
set role_id = 8
where employee_id = 17;

select *
from roles_employee;