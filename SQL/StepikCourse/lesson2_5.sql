-- Включить нового человека в таблицу с клиентами. Его имя Попов Илья, его email popov@test, проживает он в Москве.

INSERT INTO client (name_client, city_id, email)
SELECT 'Попов Илья', city_id, 'popov@test'             -- В запросах на добавление можно одновременно заносить и новые значения и данные из других таблиц.
FROM city
WHERE city_id = 1;

SELECT * FROM client;


-- Создать новый заказ для Попова Ильи. Его комментарий для заказа: «Связаться со мной по вопросу доставки».

INSERT INTO buy (buy_description, client_id)
SELECT 'Связаться со мной по вопросу доставки', client_id
FROM client
WHERE name_client = 'Попов Илья';

SELECT * FROM buy;


-- В таблицу buy_book добавить заказ с номером 5. Этот заказ должен содержать книгу Пастернака «Лирика» в количестве двух экземпляров и книгу Булгакова «Белая гвардия» в одном экземпляре.

INSERT INTO buy_book(buy_id, book_id, amount)
SELECT 5, book_id, 2
FROM book
WHERE title = 'Лирика';

INSERT INTO buy_book(buy_id, book_id, amount)
SELECT 5, book_id, 1
FROM book
WHERE title = 'Белая гвардия';

SELECT * FROM buy_book;

 ----- Второй вариант -----

INSERT INTO buy_book(buy_id, book_id, amount)
VALUES(5, (SELECT book_id
           FROM book b
                JOIN author a ON a.author_id = b.author_id
           WHERE title = 'Лирика' AND name_author LIKE 'Пастернак%'), 2),
      (5, (SELECT book_id
           FROM book b
                JOIN author a ON a.author_id = b.author_id
           WHERE title = 'Белая гвардия' AND name_author LIKE 'Булгаков%'), 1);

SELECT * FROM buy_book;


-- Количество тех книг на складе, которые были включены в заказ с номером 5, уменьшить на то количество, которое в заказе с номером 5  указано.

UPDATE book b 
       JOIN buy_book bb ON bb.book_id = b.book_id
SET b.amount = b.amount - bb.amount
WHERE buy_id = 5;

SELECT * from book;


-- Создать счет (таблицу buy_pay) на оплату заказа с номером 5, в который включить название книг, их автора, цену, количество заказанных книг и  стоимость. Последний столбец назвать Стоимость. Информацию в таблицу занести в отсортированном по названиям книг виде.

CREATE TABLE buy_pay AS
SELECT title, name_author, price, bb.amount, price * bb.amount AS Стоимость
FROM book b
     JOIN author a ON a.author_id = b.author_id
     JOIN buy_book bb ON bb.book_id = b.book_id
WHERE buy_id = 5
ORDER BY title;

SELECT * FROM buy_pay;


-- Создать общий счет (таблицу buy_pay) на оплату заказа с номером 5. Куда включить номер заказа, количество книг в заказе (название столбца Количество) и его общую стоимость (название столбца Итого).  Для решения используйте ОДИН запрос.

CREATE TABLE buy_pay                                                            -- Группировку использовать не обязательно, т.к. в столбце buy_id у нас одинаковые значения равные 5.
SELECT buy_id, SUM(bb.amount) AS Количество, SUM(bb.amount*price) AS Итого      -- В таком случае у нас группа образуется изначально без GROUP BY при использовании агрегатных функций,
FROM book b                                                                     -- в данном случае SUN().
     JOIN buy_book bb ON bb.book_id = b.book_id
WHERE buy_id = 5;

SELECT * from buy_pay;


-- В таблицу buy_step для заказа с номером 5 включить все этапы из таблицы step, которые должен пройти этот заказ. В столбцы date_step_beg и date_step_end всех записей занести Null.

INSERT INTO buy_step (buy_id, step_id, date_step_beg, date_step_end)
SELECT DISTINCT buy_id, step_id, NULL, NULL
FROM step, buy_book
WHERE buy_id = 5;

SELECT * FROM buy_step;


-- В таблицу buy_step занести дату 12.04.2020 выставления счета на оплату заказа с номером 5.
-- Правильнее было бы занести не конкретную, а текущую дату. Это можно сделать с помощью функции Now(). Но при этом в разные дни будут вставляться разная дата, и задание нельзя будет проверить, поэтому  вставим дату 12.04.2020.

UPDATE buy_step
SET date_step_beg = '2020-04-12'
WHERE buy_id = 5 AND step_id = 1;

SELECT * FROM buy_step;


-- Завершить этап «Оплата» для заказа с номером 5, вставив в столбец date_step_end дату 13.04.2020, и начать следующий этап («Упаковка»), задав в столбце date_step_beg для этого этапа ту же дату.
-- Реализовать два запроса для завершения этапа и начала следующего. Они должны быть записаны в общем виде, чтобы его можно было применять для любых этапов, изменив только текущий этап. Для примера пусть это будет этап «Оплата».

UPDATE buy_step
SET date_step_end = '2020-04-13'
WHERE buy_id = 5 AND step_id = 1;

UPDATE buy_step 
SET date_step_beg = '2020-04-13'
WHERE buy_id = 5 AND step_id = (SELECT step_id+1
                                   FROM step
                                   WHERE name_step = 'Оплата');

SELECT * FROM buy_step


