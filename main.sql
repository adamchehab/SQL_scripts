-- создаем бд
DROP DATABASE if EXISTS testing;
CREATE DATABASE testing;
USE testing;

-- Создаем таблицы и связи
DROP TABLE if EXISTS answer, subject, question, testing;


CREATE TABLE answer(
    answer_id INT PRIMARY KEY AUTO_INCREMENT,
    name_answer VARCHAR(255) NOT NULL,
    question_id INT NOT NULL,
    is_correct INT NOT NULL
);

CREATE TABLE subject(
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    name_subject VARCHAR(255) NOT NULL
);

CREATE TABLE question(
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    name_question VARCHAR(255) NOT NULL,
    subject_id INT NOT NULL,
    CONSTRAINT subject_const FOREIGN KEY (subject_id) REFERENCES subject(subject_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE testing(
    testing_id INT PRIMARY KEY AUTO_INCREMENT,
    attempt_id INT NOT NULL,
    question_id INT NOT NULL,
    answer_id INT NOT NULL,
    CONSTRAINT question_constr FOREIGN KEY (question_id) REFERENCES question(question_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT answer_constr FOREIGN KEY (answer_id) REFERENCES answer(answer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Заполняем таблицы данными

INSERT INTO answer(name_answer, question_id, is_correct) VALUES ('Ответ 1', 1, 1),
                                                                ('Ответ 2', 2, 1);

INSERT INTO subject(name_subject) VALUES ('Предмет 1'),
                                         ('Предмет 2');

INSERT INTO question(name_question, subject_id) VALUES ('Вопрос 1', 1),
                                                       ('Вопрос 2', 2);

INSERT INTO testing(attempt_id, question_id, answer_id) VALUES (1, 1, 1),
                                                                (2, 2, 2);

-- выводим содержимое таблиц 
SELECT * FROM subject;
SELECT * FROM question;
SELECT * FROM answer;
SELECT * FROM testing;

-- показываем как работает каскадное удаление

-- выводим содержимое таблицы subject
SELECT * FROM subject;
-- удаляем первый предмет с id = 1
DELETE FROM subject WHERE subject_id = 1;
-- выводим таблицу чтобы ппоказать что он удален
SELECT * FROM subject;
-- выводим зависимую таблицу чтобы увидеть что каскадное удаление срабоотало
SELECT * FROM question;