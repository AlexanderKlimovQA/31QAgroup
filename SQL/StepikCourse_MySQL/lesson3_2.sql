-- В таблицу attempt включить новую попытку для студента Баранова Павла по дисциплине «Основы баз данных». Установить текущую дату в качестве даты выполнения попытки.

INSERT INTO attempt(student_id, subject_id, date_attempt)
SELECT a.student_id, a.subject_id, NOW()                    -- Функция NOW() вставляет текущую дату.
FROM student s JOIN
    attempt a ON s.student_id = a.student_id JOIN
    subject su ON su.subject_id = a.subject_id
WHERE name_student = 'Баранов Павел' AND name_subject = 'Основы баз данных';

SELECT * FROM attempt;


--  Случайным образом выбрать три вопроса по дисциплине, тестирование по которой собирается проходить студент, занесенный в таблицу attempt последним, и добавить их в таблицу testing.id последней попытки получить как максимальное значение id из таблицы attempt.

INSERT INTO testing(attempt_id, question_id)
SELECT attempt_id, question_id
FROM question q JOIN
    attempt a ON q.subject_id = a.subject_id
WHERE attempt_id = (SELECT MAX(attempt_id)
                    FROM attempt)
ORDER BY RAND()
LIMIT 3;

SELECT * FROM testing;