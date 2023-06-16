CREATE TABLE films (
    id INT PRIMARY KEY AUTO_INCREMENT,
    film_name_rus VARCHAR(150) NOT NULL,
    series_name_orig VARCHAR(150) NOT NULL,
    release_date DATE NOT NULL,
    my_rating INT DEFAULT NULL,
    book_id INT DEFAULT NULL,
    FOREIGN KEY (book_id)
    	REFERENCES books(id)
);

CREATE TABLE series (
    id INT PRIMARY KEY AUTO_INCREMENT,
    series_name_rus VARCHAR(150) NOT NULL,
    series_name_orig VARCHAR(150) NOT NULL,
    release_date DATE NOT NULL,
    my_rating INT DEFAULT NULL,
    book_id INT DEFAULT NULL,
    FOREIGN KEY (book_id)
    	REFERENCES books(id)
);

CREATE TABLE books (
	id INT PRIMARY KEY AUTO_INCREMENT,
	book_name_rus VARCHAR(150) NOT NULL,
	book_name_orig VARCHAR(150) DEFAULT 'нет названия на английском' NOT NULL,
	release_date DATE NOT NULL
);

-- Изменение названия столбца в таблице
ALTER TABLE series
RENAME COLUMN series_name_eng TO series_name_orig;

-- Добавление внешнего ключа в таблицу
ALTER TABLE films 
ADD FOREIGN KEY (book_id)
	REFERENCES books(id);

-- Добавление столбца language_of_writing в таблицу books
ALTER TABLE books
ADD COLUMN language_of_writing VARCHAR(50) NOT NULL
AFTER book_name_orig;

-- Посмотреть настройки полей в таблице  
SHOW COLUMNS FROM films;
   
-- Вставить данные в таблицу films
INSERT INTO films (film_name_rus, film_name_orig, release_date, my_rating, book_id)
VALUES ('Грань будущего', 'Edge of Tomorrow', '2014-05-28', 10, 13);

-- Вставить данные в таблицу series
INSERT INTO series (series_name_rus, series_name_orig, release_date, my_rating, book_id)
VALUES ('Грань будущего', 'Edge of Tomorrow', '2014-05-28', NULL, 12);

-- Вставить данные в таблицу books
INSERT INTO books (book_name_rus, book_name_orig, language_of_writing, release_date)
VALUES ('Грань будущего', 'All You Need Is Kill', 'японский', '2004-12-18');

-- Обновление данных в таблице
UPDATE series
SET series_name_orig = 'Banshee'
WHERE series_name_rus = 'Банши';

-- Добавления языка, на котором была написана книга
UPDATE books
SET release_date = '1967-01-01'
WHERE book_name_rus IN ('Мастер и Маргарита');

-- Посмотреть все фильмы в БД
SELECT * FROM films;

-- Посмотреть все сериалы в БД
SELECT * FROM series;

-- Посмотреть список книг, по которым сняты фильмы и сериалы
SELECT * FROM books;

-- Посмотреть фильмы, которые сняты по книгам
SELECT  
	film_name_rus, 
	film_name_orig, 
	films.release_date,
	my_rating,
	book_name_rus AS снят_по_книге,
	book_name_orig AS оригинальное_название_книги,
	language_of_writing AS 'язык книги',
	books.release_date AS дата_выхода_книги
FROM films JOIN
	books ON books.id = films.book_id;

-- Посмотреть фильмы и сериалы в одной таблице, снятые по книгам
SELECT film_name_rus, 
	film_name_orig, 
	films.release_date,
	my_rating,
	book_name_rus AS снят_по_книге,
	book_name_orig AS оригинальное_название_книги,
	language_of_writing AS 'язык написания',
	books.release_date AS дата_выхода_книги
FROM films JOIN
	books ON books.id = films.book_id
UNION
SELECT series_name_rus, 
	series_name_orig, 
	series.release_date,
	my_rating,
	book_name_rus,
	book_name_orig,
	language_of_writing,
	books.release_date 
FROM series JOIN
	books ON books.id = series.book_id;
	
-- Посмотреть фильмы и сериалы в одной таблице
SELECT * FROM series
UNION
SELECT * FROM films;

SELECT *
FROM films
WHERE my_rating > 6;

-- Вывод четных/нечетных ID. При остаттке от деления = 0 - выводятся четные, при остатке = 1 - выводятся нечётные
SELECT *
FROM films
WHERE MOD(id, 2) = 0;