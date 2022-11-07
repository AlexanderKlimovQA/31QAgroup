-- Создать таблицу fine

CREATE TABLE fine(
  fine_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30),
  number_plate VARCHAR(5),
  violation VARCHAR(50),
  sum_fine DECIMAL(8, 2),
  date_violation DATE,
  date_payment DATE
);


--  В таблицу fine первые 5 строк уже занесены. Добавить в таблицу записи с ключевыми значениями 6, 7, 8.

INSERT INTO fine(name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES
('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL),
('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL);

SELECT *
FROM fine;


-- Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation. При этом суммы заносить только в пустые поля столбца sum_fine.

UPDATE fine AS f, traffic_violation AS tv
SET f.sum_fine = tv.sum_fine
WHERE f.violation = tv.violation AND f.sum_fine IS NULL;

SELECT *
FROM fine


-- Вывести фамилию, номер машины и нарушение только для тех водителей, которые на одной машине нарушили одно и то же правило два и более раз. При этом учитывать все нарушения, независимо от того оплачены они или нет. Информацию отсортировать в алфавитном порядке, сначала по фамилии водителя, потом по номеру машины и, наконец, по нарушению.

SELECT name, number_plate, violation
FROM fine
GROUP BY name, number_plate, violation
HAVING COUNT(*) >= 2
ORDER BY name, number_plate, violation;


-- В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей. 

UPDATE fine, 
(SELECT name, number_plate, violation                       -- Здесь мы выбираем в UPDATE еще одну такую же таблицу и даем ей псевдноим, для того, что бы затем сравнивать
FROM fine                                                   -- значения двух таблиц и по ним осуществлять выборку.
GROUP BY name, number_plate, violation
HAVING COUNT(*) >= 2) query_in
SET fine.sum_fine = fine.sum_fine * 2
WHERE fine.date_payment IS NULL AND
      fine.name = query_in.name AND
      fine.number_plate = query_in.number_plate AND
      fine.violation = query_in.violation;


-- Необходимо:

    -- 1. В таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment; 
    -- 2. Уменьшить начисленный штраф в таблице fine в два раза  (только для тех штрафов, информация о которых занесена в таблицу payment) , если оплата произведена не позднее 20 дней со дня нарушения.

UPDATE fine f, payment p                              -- Если в обновлении участвует несколько таблиц, их все необходимо указать после UPDATE;
SET f.date_payment = p.date_payment,
    sum_fine = IF(DATEDIFF(p.date_payment, f.date_violation) <= 20, f.sum_fine / 2, f.sum_fine)
WHERE (f.name, f.number_plate, f.violation, f.date_violation) = (p.name, p.number_plate, p.violation, p.date_violation);


-- Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах (Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа  и  дату нарушения) из таблицы fine.

CREATE TABLE back_payment                                       -- Для создания таблицы на основе другой, после CREATE TABLE делаем простой SELECT с той выборкой, которую
SELECT name, number_plate, violation, sum_fine, date_violation  -- хотим внести в новую табицу.
FROM fine
WHERE date_payment IS NULL;


