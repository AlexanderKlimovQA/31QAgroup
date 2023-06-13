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
	book_name_eng VARCHAR(150) DEFAULT 'нет названия на английском' NOT NULL,
	release_date DATE NOT NULL
);

-- Изменение названия столбца в таблице
ALTER TABLE series
RENAME COLUMN series_name_eng TO series_name_orig;

-- Добавление внешнего ключа в таблицу
ALTER TABLE films 
ADD FOREIGN KEY (book_id)
	REFERENCES books(id);

-- Посмотреть настройки полей в таблице  
SHOW COLUMNS FROM films;
   
-- Вставить данные в таблицу films
INSERT INTO films (film_name_rus, film_name_orig, release_date, my_rating, book_id)
VALUES ('Смерть на Ниле', 'Death on the Nile', '2022-02-09', 8, 8);

-- Вставить данные в таблицу series
INSERT INTO series (series_name_rus, series_name_orig, release_date, my_rating, book_id)
VALUES ('Игра престолов', 'Game of Thrones', '2011-04-16', 7, 9);

-- Вставить данные в таблицу books
INSERT INTO books (book_name_rus, book_name_orig, release_date)
VALUES ('Игра престолов', 'A Game of Thrones', '1996-08-01');

-- Обновление данных в таблице
UPDATE series
SET series_name_orig = 'Banshee'
WHERE series_name_rus = 'Банши';

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
	books.release_date AS дата_выхода_книги
FROM films JOIN
	books ON books.id = films.book_id;

-- Посмотреть фильмы и сериалы в одной таблице, снятые по книгам
SELECT * FROM series JOIN
	books ON books.id = series.book_id
UNION
SELECT * FROM films JOIN
	books ON books.id = films.book_id;
	
-- Посмотреть фильмы и сериалы в одной таблице
SELECT * FROM series
UNION
SELECT * FROM films;