-- Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.

SELECT title, name_genre, price
FROM  book b JOIN
    genre g ON g.genre_id = b.genre_id
WHERE amount > 8
ORDER BY price DESC


-- Вывести все жанры, которые не представлены в книгах на складе.

SELECT name_genre 
FROM genre g LEFT JOIN
     book b ON g.genre_id = b.genre_id
WHERE b.genre_id IS NULL                   -- Если хотим найти строки, где значение NULL, надо писать IS NULL, = NULL не подходит.


-- Есть список городов, хранящийся в таблице city:

-- city_id 	        name_city
--    1 	          Москва
--    2 	      Санкт-Петербург
--    3 	        Владивосток

-- Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. Последний столбец назвать Дата. Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.

SELECT name_city, name_author, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY) Дата   -- DATE_ADD - служит для сложения даты с числом. 
FROM city, author                                                                              -- Синтаксис: DATE_ADD(Дата, INTERVAL число_которое_прибавляем единица_измерения).
ORDER BY name_city, Дата DESC;                                                                     -- RAND() - генерирует случайное число в диапазоне 0 - 1 не включительно.
                                                                                                   -- Если умножить функцию на 365, она будет генерить вещественный числа в диапазоне 365 (не включительно).
                                                                                                   -- FLOOR() - возвращает наибольшее целое число, меньшее или равное указанному числовому значению.


-- Next Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.

SELECT name_genre, title, name_author
FROM genre g
     JOIN book b ON b.genre_id = g.genre_id
     JOIN author a ON a.author_id = b.author_id
WHERE name_genre LIKE "%роман%"
ORDER BY title;


-- Посчитать количество экземпляров  книг каждого автора из таблицы author.  Вывести тех авторов,  количество книг которых меньше 10, в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.

SELECT name_author, SUM(amount) AS Количество
FROM author a
     LEFT JOIN book b ON b.author_id = a.author_id
GROUP BY name_author
HAVING SUM(amount) < 10 OR SUM(amount) IS NULL       -- Т.к. в операторе сравнение NULL не учитывается, нужно указать для него дополнительное условие после OR.
ORDER BY Количество;

            ---- Второй вариант ----

SELECT name_author, SUM(amount) AS Количество
FROM author a
     LEFT JOIN book b ON b.author_id = a.author_id
GROUP BY name_author
HAVING IFNULL(SUM(amount), 0) < 10                    -- Используем функцию IFNULL, которая возвращает заданное значение, если выражение равно NULL.
ORDER BY Количество;


-- Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре.

SELECT name_author                               
FROM author a
     JOIN book b ON b.author_id = a.author_id       -- Достаточно связать 2 таблицы, т. к. нам не обязательны названия жанров, достаточны лишь их ID из колонки genre_id
GROUP BY name_author                                -- с помощью который происходит связь с таблицей genre.
HAVING COUNT(DISTINCT genre_id) = 1               -- Тут с помощью оператора DISTINCT считаем сумму одинаковых значений в поле genre_id. 
ORDER BY name_author;                             -- Задача найти тех, у кого будет лишь одно уникальное значение, значит этот автор пишет только в одном жанре. Иначе сумма уникальных значений была бы > 1.