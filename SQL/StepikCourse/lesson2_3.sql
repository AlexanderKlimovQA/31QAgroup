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