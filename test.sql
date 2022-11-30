-- создаем бд
DROP DATABASE IF EXISTS book_store;
CREATE DATABASE book_store;
USE book_store;

-- создаем таблицы
DROP TABLE IF EXISTS genre, book, buy_book;

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(20),
    author_id INT NOT NULL,
    genre_id INT NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL
);

CREATE TABLE genre(
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(20) NOT NULL
);

CREATE TABLE buy_book(
    buy_book_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_id INT NOT NULL,
    book_id INT NOT NULL,
    amount INT NOT NULL
);

--Создаем связи
ALTER TABLE book ADD CONSTRAINT book_id_constr FOREIGN KEY (genre_id) REFERENCES genre(genre_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE buy_book ADD CONSTRAINT buy_book_constr FOREIGN KEY (book_id) REFERENCES book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;

-- Добавляем колонку
ALTER TABLE book ADD genre_id_new INT NOT NULL;
-- Копируем старую колонку в новую
UPDATE book SET genre_id_new=genre_id;

-- Дропаем старый ключ
ALTER TABLE book DROP CONSTRAINT book_id_constr;
-- Дропаем старую колонку
ALTER TABLE book DROP genre_id;

-- Добавляем ключ к новой колонке
ALTER TABLE book ADD CONSTRAINT book_id_constr FOREIGN KEY (genre_id_new) REFERENCES genre(genre_id) ON UPDATE CASCADE ON DELETE CASCADE;
-- Переименовываем новую колонку в старую
ALTER TABLE book RENAME COLUMN genre_id_new TO genre_id;