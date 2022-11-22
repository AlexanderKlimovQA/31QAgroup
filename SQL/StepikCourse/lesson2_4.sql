-- Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном по номеру заказа и названиям книг виде.

SELECT buy.buy_id, title, price, bb.amount
FROM client c
     JOIN buy ON buy.client_id = c.client_id
     JOIN buy_book bb ON bb.buy_id = buy.buy_id
     JOIN book b ON b.book_id = bb.book_id
WHERE name_client = 'Баранов Павел'
ORDER BY buy.buy_id, title;


-- Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга).  Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг.

SELECT name_author, title, COUNT(bb.book_id) AS Количество
FROM buy_book bb
     RIGHT JOIN book b ON b.book_id = bb.book_id     -- Т.к. нужно было найти и кол-во заказов книг, которые еще не заказывались (т.е. которых нет в таблице buy_book)
     JOIN author a ON a.author_id = b.author_id      -- использовалось внешнее соединение с помощью RIGHT JOIN.
GROUP BY title, name_author                             -- Можно группировать сразу по двум и более столбцам, тогда в группу будут состоять из строк
ORDER BY name_author, title;                            -- в которых указанные после GROUP BY столбцы будут полностью идентичны.


-- Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец назвать Количество. Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов.

SELECT name_city, COUNT(buy_id) AS Количество
FROM city c
     JOIN client cl ON cl.city_id = c.city_id
     JOIN buy b ON b.client_id = cl.client_id
WHERE buy_id > 0
GROUP BY name_city
ORDER BY Количество DESC, name_city;


-- Вывести номера всех оплаченных заказов и даты, когда они были оплачены.

SELECT buy_id, date_step_end
FROM buy_step
WHERE step_id = 1 AND date_step_end IS NOT NULL


-- Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость (сумма произведений количества заказанных книг и их цены), в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость.

SELECT b.buy_id, name_client, SUM(price*bb.amount) AS Стоимость
FROM buy b
     JOIN client c ON c.client_id = b.client_id
     JOIN buy_book bb ON bb.buy_id = b.buy_id
     JOIN book ON book.book_id = bb.book_id
GROUP BY b.buy_id, name_client
ORDER BY b.buy_id;


-- Вывести номера заказов (buy_id) и названия этапов,  на которых они в данный момент находятся. Если заказ доставлен –  информацию о нем не выводить. Информацию отсортировать по возрастанию buy_id.

SELECT b.buy_id, name_step
FROM buy b
     JOIN buy_step bs ON bs.buy_id = b.buy_id
     JOIN step s ON s.step_id = bs.step_id
WHERE date_step_beg IS NOT NULL AND date_step_end IS NULL;


-- В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город (рассматривается только этап "Транспортировка"). Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, указать количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id), а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде.

SELECT b.buy_id, DATEDIFF(date_step_end, date_step_beg) AS Количество_дней, IF(DATEDIFF(date_step_end, date_step_beg) > days_delivery, DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0) AS Опоздание
FROM city c
     JOIN client cl ON cl.city_id = c.city_id
     JOIN buy b ON b.client_id = cl.client_id
     JOIN buy_step bs ON bs.buy_id = b.buy_id
     JOIN step s ON s.step_id = bs.step_id
WHERE name_step = 'Транспортировка' AND date_step_end IS NOT NULL
ORDER BY b.buy_id;

     ----- Второй вариант с использованием функции GREATEST() вместо IF() -----
SELECT b.buy_id, DATEDIFF(date_step_end, date_step_beg) AS Количество_дней, GREATEST(DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0) AS Опоздание
FROM city c
     JOIN client cl ON cl.city_id = c.city_id             -- GREATEST выполняет математическое вычисление указанное в первом условии, и если его результат больше, чем условия указанное после запятой
     JOIN buy b ON b.client_id = cl.client_id             -- (в данном случае "0"), то возвращает полученный результат. Если результат меньше указанного условия, то возвращает
     JOIN buy_step bs ON bs.buy_id = b.buy_id             -- число, равное этому условия. В данном запросе если заказ пришел вовремя или быстрее, то при вычитании у нас получается отрицательное число
     JOIN step s ON s.step_id = bs.step_id                -- которое приравняется к "0". Если заказ пришел с опозданием, то вернется кол-во дней, на которое он опоздал.
WHERE name_step = 'Транспортировка' AND date_step_end IS NOT NULL
ORDER BY b.buy_id;


-- Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде. В решении используйте фамилию автора, а не его id.

SELECT DISTINCT name_client
FROM client c
     JOIN buy ON buy.client_id = c.client_id
     JOIN buy_book bb ON bb.buy_id = buy.buy_id
     JOIN book b ON b.book_id = bb.book_id
     JOIN author a ON a.author_id = b.author_id
WHERE name_author LIKE "Достоевский%"
ORDER BY name_client;


-- Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество. Последний столбец назвать Количество.

SELECT name_genre, SUM(bb.amount) AS Количество
FROM genre g
    JOIN book b ON b.genre_id = g.genre_id
    JOIN buy_book bb ON bb.book_id = b.book_id
GROUP BY name_genre
HAVING SUM(bb.amount) >= ALL(
    SELECT SUM(bb.amount) AS sum_amount
    FROM book b
    JOIN buy_book bb ON bb.book_id = b.book_id
    GROUP BY genre_id
    );


-- Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. Для этого вывести год, месяц, сумму выручки в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде. Название столбцов: Год, Месяц, Сумма.

SELECT YEAR(date_step_end) AS Год, MONTHNAME(date_step_end) AS Месяц, SUM(price*bb.amount) AS Сумма
FROM book b
     JOIN buy_book bb ON bb.book_id = b.book_id
     JOIN buy_step bs ON bs.buy_id = bb.buy_id
WHERE date_step_end IS NOT NULL AND step_id = 1
GROUP BY Год, Месяц
UNION
SELECT YEAR(date_payment) AS Год, MONTHNAME(date_payment) AS Месяц, SUM(price*amount)
FROM buy_archive
GROUP BY Год, Месяц
ORDER BY Месяц, Год;


