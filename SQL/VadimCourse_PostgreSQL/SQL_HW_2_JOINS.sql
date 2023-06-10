-- 1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
SELECT *
FROM employees e JOIN
	employee_salary es ON e.id = es.employee_id;

-- 2. Вывести всех работников у которых ЗП меньше 2000.
SELECT *
FROM employees e JOIN
	employee_salary es ON e.id = es.employee_id JOIN
	salary s ON s.id = es.salary_id
WHERE monthly_salary < 2000;

-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
SELECT *
FROM employees e RIGHT JOIN
	employee_salary es ON e.id = es.employee_id
WHERE e.id IS NULL;

-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
UPDATE employee_salary			-- Обновил salary_id двух работников, т.к. у всех была ЗП < 2000
SET salary_id = 16
WHERE employee_id IN (73, 79);

SELECT *
FROM employees e RIGHT JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE e.id IS NULL AND monthly_salary < 2000;

-- 5. Найти всех работников кому не начислена ЗП.
SELECT *
FROM employees e LEFT JOIN
	employee_salary es ON e.id = es.employee_id
WHERE salary_id IS NULL;

-- 6. Вывести всех работников с названиями их должности.
SELECT e.id AS "ID сотрудника", employee_name AS "Имя сотрудника", r.id AS "ID должности", role_name AS "Должность"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id;

-- 7. Вывести имена и должность только Java разработчиков.
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id
WHERE role_name LIKE '%Java %';

-- 8. Вывести имена и должность только Python разработчиков.
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id
WHERE role_name LIKE '%Python%';

-- 9. Вывести имена и должность всех QA инженеров.
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id
WHERE role_name LIKE '%QA%';

-- 10. Вывести имена и должность ручных QA инженеров.
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id
WHERE role_name LIKE '%Manual QA%';

-- 11. Вывести имена и должность автоматизаторов QA
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id
WHERE role_name LIKE '%Automation QA%';

-- 12. Вывести имена и зарплаты Junior специалистов
SELECT employee_name AS "Имя сотрудника", monthly_salary AS "ЗП Junior специалистов"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%Junior%';

-- 13. Вывести имена и зарплаты Middle специалистов
SELECT employee_name AS "Имя сотрудника", monthly_salary AS "ЗП Middle специалистов"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%Middle%';

-- 14. Вывести имена и зарплаты Senior специалистов
SELECT employee_name AS "Имя сотрудника", monthly_salary AS "ЗП Senior специалистов"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%Senior%';

-- 15. Вывести зарплаты Java разработчиков
SELECT monthly_salary AS "ЗП Java разработчиков"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%Java %';

-- 16. Вывести зарплаты Python разработчиков
SELECT monthly_salary AS "ЗП Python разработчиков"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%Python%';

-- 17. Вывести имена и зарплаты Junior Python разработчиков
SELECT employee_name AS "Имя сотрудника", monthly_salary AS "ЗП Junior Python разработчиков"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE 'Junior Python%';

-- 18. Вывести имена и зарплаты Middle JS разработчиков
SELECT employee_name AS Имя_сотрудника, monthly_salary AS "ЗП Middle JS разработчиков"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name = 'Middle JavaScript developer';

-- 19. Вывести имена и зарплаты Senior Java разработчиков
SELECT employee_name AS Имя_сотрудника, monthly_salary AS "ЗП Senior Java разработчиков"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name = 'Senior Java developer';

-- 20. Вывести зарплаты Junior QA инженеров
SELECT monthly_salary AS "ЗП Junior QA"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE 'Junior%QA%';

-- 21. Вывести среднюю зарплату всех Junior специалистов
SELECT AVG(monthly_salary) AS "Средняя ЗП Junior специалистов"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%Junior%';

-- 22. Вывести сумму зарплат JS разработчиков
SELECT SUM(monthly_salary) AS "Сумма ЗП JS разработчиков"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%JavaScript%';

-- 23. Вывести минимальную ЗП QA инженеров
SELECT MIN(monthly_salary) AS "Минимальная ЗП QA"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%QA%';

-- 24. Вывести максимальную ЗП QA инженеров
SELECT MAX(monthly_salary) AS "Максимальная ЗП QA"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%QA%';

-- 25. Вывести количество QA инженеров
SELECT COUNT(e.id) AS "Кол-во QA на проекте"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id
WHERE role_name LIKE '%QA%';

-- 26. Вывести количество Middle специалистов.
SELECT COUNT(e.id) AS "Кол-во Middle на проекте"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id
WHERE role_name LIKE '%Middle%';

-- 27. Вывести количество разработчиков
SELECT COUNT(e.id) AS "Кол-во разработчиков на проекте"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id
WHERE role_name LIKE '%developer%';

-- 28. Вывести фонд (сумму) зарплаты разработчиков.
SELECT SUM(monthly_salary) AS "Сумма ЗП разработчиков"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE role_name LIKE '%developer%';

-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность", monthly_salary AS "Зарплата"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
ORDER BY monthly_salary ASC;

-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность", monthly_salary AS "Зарплата"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE monthly_salary BETWEEN 1700 AND 2300
ORDER BY monthly_salary ASC;

-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность", monthly_salary AS "Зарплата"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE monthly_salary < 2300
ORDER BY monthly_salary ASC;

-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
SELECT employee_name AS "Имя сотрудника", role_name AS "Должность", monthly_salary AS "Зарплата"
FROM employees e JOIN
	roles_employee re ON e.id = re.employee_id JOIN
	roles r ON r.id = re.role_id JOIN
	employee_salary es ON e.id = es.employee_id JOIN 
	salary s ON s.id = es.salary_id
WHERE monthly_salary IN (1100, 1500, 2000)
ORDER BY monthly_salary ASC;