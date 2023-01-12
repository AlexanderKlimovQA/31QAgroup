-- Создать вспомогательную таблицу applicant,  куда включить id образовательной программы,  id абитуриента, сумму баллов абитуриентов (столбец itog) в отсортированном сначала по id образовательной программы, а потом по убыванию суммы баллов виде.

CREATE TABLE applicant AS
SELECT pe.program_id, es.enrollee_id, SUM(result) AS itog
FROM program_enrollee pe JOIN
    enrollee_subject es ON es.enrollee_id = pe.enrollee_id JOIN
    program_subject ps ON ps.subject_id = es.subject_id AND ps.program_id = pe.program_id
GROUP BY program_id, enrollee_id
ORDER BY program_id, itog DESC;


-- Из таблицы applicant, созданной на предыдущем шаге, удалить записи, если абитуриент на выбранную образовательную программу не набрал минимального балла хотя бы по одному предмету.

