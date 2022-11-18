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