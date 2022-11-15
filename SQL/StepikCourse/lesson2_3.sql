--Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply), необходимо в таблице book увеличить количество на значение, указанное в поставке,  и пересчитать цену. А в таблице  supply обнулить количество этих книг. Формула для пересчета цены: price = ​((p1​∗k1)​+(p2​∗k2​))​ : (k1​+k2)

UPDATE book b
       JOIN supply s ON s.title = b.title
       JOIN author a ON a.author_id = b.author_id AND a.name_author = s.author  -- Этот запрос должен отобрать строки из таблиц book и supply такие, что у них совпадают и автор, и название книги.
SET b.price = (b.price*b.amount+s.price*s.amount)/(b.amount+s.amount),          -- Но в таблице supply фамилия автора записана не числом (id), а текстом. Следовательно,
    b.amount = b.amount+s.amount,                                               -- чтобы выполнить сравнение по фамилии автора нужно "подтянуть" таблицу author,
    s.amount = 0                                                                -- которая связана с book по столбцу author_id.  И в логическом выражении, описывающем соединение
WHERE b.price != s.price;                                                       -- таблиц, можно будет использовать столбцы из таблиц book, authorи supply. 

SELECT * FROM book;

SELECT * FROM supply;


-- Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author.  Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.

INSERT INTO author (name_author)
SELECT s.author
FROM supply s
     LEFT JOIN author a ON a.name_author = s.author
WHERE name_author IS NULL;

SELECT * FROM author;


-- Добавить новые книги из таблицы supply в таблицу book на основе сформированного выше запроса. Затем вывести для просмотра таблицу book.

INSERT INTO book (title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM author a
     JOIN supply s ON s.author = a.name_author
WHERE amount != 0;

SELECT * FROM book;


--  Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения». (Использовать два запроса).

    ----- Самый простой вариант из двух запросов -----
UPDATE book             -- Подразумевается, что мы знаем и ID книги и ID жанра. В следующем запросе будем считать, что мы знаем только название жанра.
SET genre_id = 2
WHERE book_id = 10;

UPDATE book
SET genre_id = 3
WHERE book_id = 11;

SELECT * FROM book;

    ----- Второй вариант с подзапросом -----
UPDATE book
SET genre_id = (
                SELECT genre_id
                FROM genre
                WHERE name_genre = 'Поэзия'
                )
WHERE book_id = 10;

UPDATE book
SET genre_id = (
                SELECT genre_id
                FROM genre
                WHERE name_genre = 'Приключения'
                )
WHERE book_id = 11;

SELECT * FROM book;

    ----- Третий вариант, не зная никакие id -----
                  
UPDATE book
       JOIN author ON author.author_id = book.author_id                    -- Т.к. в таблице book в столбце title есть две строки с названием 'Стихотворения и поэмы', которые принадлежат 
SET genre_id = (SELECT genre_id                                            -- разным авторам, джойним к таблице book таблицу author для уточненения, чьи именно 
                FROM genre                                                 -- 'Стихотворения и поэмы' мы собираемся апдейтить.
                WHERE name_genre = 'Поэзия')
WHERE title = 'Стихотворения и поэмы' AND name_author = 'Лермонтов М.Ю.';
                  
UPDATE book
       JOIN author ON author.author_id = book.author_id                    -- Во-втором запросе это не обязательно, но при работе с большими БД допускаю, что может быть ситуация, когда  книги 
SET genre_id = (SELECT genre_id                                            -- малоизвестных авторов могут быть с названиями известных. Т.к. вряд-ли мы знаем все книги планеты, лучше сразу 
                FROM genre                                                 -- уточнить, какой автор имеется ввиду.
                WHERE name_genre = 'Приключения')
WHERE title = 'Остров сокровищ' AND name_author = 'Стивенсон Р.Л.';


SELECT title, name_author, book.author_id, genre_id 
FROM book 
     JOIN author ON author.author_id = book.author_id;
