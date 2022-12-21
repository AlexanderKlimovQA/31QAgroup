-- Вывести абитуриентов, которые хотят поступать на образовательную программу «Мехатроника и робототехника» в отсортированном по фамилиям виде.

SELECT name_enrollee
FROM enrollee e JOIN
    program_enrollee pe ON e.enrollee_id = pe.enrollee_id JOIN
    program p ON p.program_id = pe.program_id
WHERE name_program  = 'Мехатроника и робототехника'
ORDER BY name_enrollee;


-- Вывести образовательные программы, на которые для поступления необходим предмет «Информатика». Программы отсортировать в обратном алфавитном порядке.

SELECT name_program
FROM program p JOIN
    program_subject ps ON p.program_id = ps.program_id JOIN
    subject s ON s.subject_id = ps.subject_id
WHERE name_subject = 'Информатика'
ORDER BY name_program DESC;


-- Выведите количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и среднее значение баллов по предмету ЕГЭ. Вычисляемые столбцы назвать Количество, Максимум, Минимум, Среднее. Информацию отсортировать по названию предмета в алфавитном порядке, среднее значение округлить до одного знака после запятой.

SELECT name_subject, COUNT(enrollee_id) AS Количество, MAX(result) AS Максимум, MIN(result) AS Минимум, ROUND(AVG(result), 1) AS Среднее
FROM subject s JOIN
    enrollee_subject es ON s.subject_id = es.subject_id
GROUP BY name_subject
ORDER BY name_subject;


-- Вывести образовательные программы, для которых минимальный балл ЕГЭ по каждому предмету больше или равен 40 баллам. Программы вывести в отсортированном по алфавиту виде.

SELECT name_program
FROM program p JOIN
    program_subject ps ON p.program_id = ps.program_id
GROUP BY name_program
HAVING MIN(min_result) >= 40
ORDER BY name_program;


-- Вывести образовательные программы, которые имеют самый большой план набора,  вместе с этой величиной.

SELECT name_program, plan
FROM program
WHERE plan = (SELECT MAX(plan) FROM program);