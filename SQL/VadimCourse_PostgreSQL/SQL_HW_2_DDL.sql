-- Таблица employees

-- 1) Создать таблицу employees
-- - id. serial,  primary key,
-- - employee_name. Varchar(50), not null
-- 2) Наполнить таблицу employee 70 строками.

CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	employee_name VARCHAR(50) NOT NULL
);

INSERT INTO employees (employee_name)
VALUES 
	('12Alexander334'),
	('12Alex334'),
	('12Roma334'),
	('12Pasha334'),
	('12Dasha334'),
	('12Masha334'),
	('12Bill334'),
	('12Bale334'),
	('12Christian334'),
	('12Matros334');

SELECT * FROM employees;



-- Таблица salary

-- 1) Создать таблицу salary
-- - id. Serial  primary key,
-- - monthly_salary. Int, not null
-- 2) Наполнить таблицу salary 15 строками

CREATE TABLE salary (
	id SERIAL PRIMARY KEY,
	monthly_salary INT NOT NULL
);

INSERT INTO salary (monthly_salary)
VALUES
	(1000),
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

SELECT * FROM salary;



-- Таблица employee_salary

-- 1) Создать таблицу employee_salary
-- - id. Serial  primary key,
-- - employee_id. Int, not null, unique
-- - salary_id. Int, not null
-- 2) Наполнить таблицу employee_salary 40 строками:
-- - в 10 строк из 40 вставить несуществующие employee_id

CREATE TABLE employee_salary (
	id SERIAL PRIMARY KEY,
	employee_id INT NOT NULL UNIQUE,
	salary_id INT NOT NULL
);

INSERT INTO employee_salary (employee_id, salary_id)
VALUES
	(71, 10),
	(72, 9),
	(73, 8),
	(74, 7),
	(75, 6),
	(76, 5),
	(77, 4),
	(78, 3),
	(79, 2),
	(80, 1);

SELECT * FROM employee_salary;



-- Таблица roles

-- 1) Создать таблицу roles
-- - id. Serial  primary key,
-- - role_name. int, not null, unique
-- 2) Поменять тип столба role_name с int на varchar(30)
-- 3) Наполнить таблицу roles 20 строками

CREATE TABLE roles (
	id SERIAL PRIMARY KEY,
	role_name INT NOT NULL UNIQUE
);

ALTER TABLE roles
ALTER COLUMN role_name TYPE VARCHAR (30);

INSERT INTO roles (role_name)
VALUES
	('Junior Python developer'),
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

SELECT * FROM roles;



-- Таблица roles_employee

-- 1) Создать таблицу roles_employee
-- - id. Serial  primary key,
-- - employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
-- - role_id. Int, not null (внешний ключ для таблицы roles, поле id)
-- 2) Наполнить таблицу roles_employee 40 строками

CREATE TABLE roles_employee (
	id SERIAL PRIMARY KEY,
	employee_id INT NOT NULL UNIQUE,
	role_id INT NOT NULL,
	FOREIGN KEY (employee_id)
		REFERENCES employees(id),
	FOREIGN KEY (role_id)
		REFERENCES roles(id)
);

INSERT INTO roles_employee (employee_id, role_id)
VALUES
	(31, 20),
	(32, 19),
	(33, 18),
	(34, 17),
	(35, 16),
	(36, 15),
	(37, 14),
	(38, 13),
	(39, 12),
	(40, 11);

SELECT * FROM roles_employee;