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


-- Посчитать, сколько дополнительных баллов получит каждый абитуриент. Столбец с дополнительными баллами назвать Бонус. Информацию вывести в отсортированном по фамилиям виде.

SELECT name_enrollee,  IF(SUM(bonus) IS NULL, 0, SUM(bonus)) AS Бонус
FROM enrollee e LEFT JOIN
    enrollee_achievement ea ON e.enrollee_id = ea.enrollee_id LEFT JOIN
    achievement a ON a.achievement_id = ea.achievement_id
GROUP BY name_enrollee
ORDER BY name_enrollee;


-- Выведите сколько человек подало заявление на каждую образовательную программу и конкурс на нее (число поданных заявлений деленное на количество мест по плану), округленный до 2-х знаков после запятой. В запросе вывести название факультета, к которому относится образовательная программа, название образовательной программы, план набора абитуриентов на образовательную программу (plan), количество поданных заявлений (Количество) и Конкурс. Информацию отсортировать в порядке убывания конкурса.

SELECT name_department, name_program, plan, COUNT(enrollee_id) AS Количество, ROUND(COUNT(enrollee_id)/plan, 2) AS Конкурс
FROM department d JOIN
    program p ON d.department_id = p.department_id JOIN
    program_enrollee pe ON p.program_id = pe.program_id
GROUP BY name_department, name_program, plan
ORDER BY Конкурс DESC;


-- Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» в отсортированном по названию программ виде.

SELECT name_program
FROM program p JOIN
    program_subject ps ON p.program_id = ps.program_id JOIN
    subject s ON s.subject_id = ps.subject_id
WHERE name_subject IN ('Информатика', 'Математика')
GROUP BY name_program
HAVING COUNT(name_subject) = 2
ORDER BY name_program;


-- Посчитать количество баллов каждого абитуриента на каждую образовательную программу, на которую он подал заявление, по результатам ЕГЭ. В результат включить название образовательной программы, фамилию и имя абитуриента, а также столбец с суммой баллов, который назвать itog. Информацию вывести в отсортированном сначала по образовательной программе, а потом по убыванию суммы баллов виде.

