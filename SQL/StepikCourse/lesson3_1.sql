--  Вывести студентов, которые сдавали дисциплину «Основы баз данных», указать дату попытки и результат. Информацию вывести по убыванию результатов тестирования

SELECT name_student, date_attempt, result
FROM student s
     JOIN attempt a ON a.student_id = s.student_id
     JOIN subject su ON su.subject_id = a.subject_id
WHERE name_subject = 'Основы баз данных'
ORDER BY result DESC;


-- Вывести, сколько попыток сделали студенты по каждой дисциплине, а также средний результат попыток, который округлить до 2 знаков после запятой. Под результатом попытки понимается процент правильных ответов на вопросы теста, который занесен в столбец result.  В результат включить название дисциплины, а также вычисляемые столбцы Количество и Среднее. Информацию вывести по убыванию средних результатов.

SELECT name_subject, COUNT(result) AS Количество, ROUND(AVG(result), 2) AS Среднее
FROM subject s
     LEFT JOIN attempt a ON a.subject_id = s.subject_id
GROUP BY name_subject
ORDER BY Среднее DESC;


-- Вывести студентов (различных студентов), имеющих максимальные результаты попыток . Информацию отсортировать в алфавитном порядке по фамилии студента.

SELECT name_student, result
FROM student s
     JOIN attempt a ON s.student_id = a.student_id
WHERE result IN (SELECT MAX(result)
                 FROM attempt)
ORDER BY name_student;


-- Если студент совершал несколько попыток по одной и той же дисциплине, то вывести разницу в днях между первой и последней попыткой. В результат включить фамилию и имя студента, название дисциплины и вычисляемый столбец Интервал. Информацию вывести по возрастанию разницы. Студентов, сделавших одну попытку по дисциплине, не учитывать. 

SELECT name_student, name_subject, DATEDIFF(MAX(date_attempt), MIN(date_attempt)) AS Интервал
FROM student s
     JOIN attempt a ON s.student_id = a.student_id
     JOIN subject su ON su.subject_id = a.subject_id
GROUP BY name_student, name_subject
HAVING COUNT(date_attempt) > 1
ORDER BY Интервал;