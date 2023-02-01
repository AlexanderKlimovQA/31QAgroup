-- Создать вспомогательную таблицу applicant,  куда включить id образовательной программы,  id абитуриента, сумму баллов абитуриентов (столбец itog) в отсортированном сначала по id образовательной программы, а потом по убыванию суммы баллов виде.

CREATE TABLE applicant AS
SELECT pe.program_id, es.enrollee_id, SUM(result) AS itog
FROM program_enrollee pe JOIN
    enrollee_subject es ON es.enrollee_id = pe.enrollee_id JOIN
    program_subject ps ON ps.subject_id = es.subject_id AND ps.program_id = pe.program_id
GROUP BY program_id, enrollee_id
ORDER BY program_id, itog DESC;


-- Из таблицы applicant, созданной на предыдущем шаге, удалить записи, если абитуриент на выбранную образовательную программу не набрал минимального балла хотя бы по одному предмету.

DELETE FROM a
USING
    applicant a JOIN
    program_subject ps ON a.program_id = ps.program_id JOIN
    enrollee_subject es ON a.enrollee_id = es.enrollee_id AND es.subject_id = ps.subject_id
WHERE result < min_result AND a.program_id = ps.program_id;
    
SELECT * FROM applicant;


-- Повысить итоговые баллы абитуриентов в таблице applicant на значения дополнительных баллов (использовать запрос из предыдущего урока).

UPDATE
applicant a JOIN
(SELECT enrollee_id, SUM(bonus) AS sum_bonus
FROM achievement a JOIN
     enrollee_achievement ea ON a.achievement_id = ea.achievement_id
GROUP BY enrollee_id) AS sum ON a.enrollee_id = sum.enrollee_id
SET itog = itog + sum_bonus;

SELECT * FROM applicant;


-- Поскольку при добавлении дополнительных баллов, абитуриенты по каждой образовательной программе могут следовать не в порядке убывания суммарных баллов, необходимо создать новую таблицу applicant_order на основе таблицы applicant. При создании таблицы данные нужно отсортировать сначала по id образовательной программы, потом по убыванию итогового балла. А таблицу applicant, которая была создана как вспомогательная, необходимо удалить.

CREATE TABLE applicant_order AS
SELECT *
FROM applicant
ORDER BY program_id, itog DESC;

SELECT * FROM applicant_order;

DROP TABLE applicant;


-- Включить в таблицу applicant_order новый столбец str_id целого типа , расположить его перед первым.

ALTER TABLE applicant_order ADD str_id INT FIRST;

SELECT * FROM applicant_order;


-- Занести в столбец str_id таблицы applicant_order нумерацию абитуриентов, которая начинается с 1 для каждой образовательной программы.

SET @row_num := 0;                  -- Способ объявления переменной в SQL
SET @pr_num := 1;

UPDATE applicant_order
SET str_id = IF(program_id = @pr_num, @row_num := @row_num + 1, @row_num := 1 AND @pr_num := @pr_num + 1);  -- Применение переменных для нумерации строк.

SELECT * FROM applicant_order;