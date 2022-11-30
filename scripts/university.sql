/*markdown
### пересоздаём БД
*/

DROP DATABASE IF EXISTS university; 
CREATE DATABASE university; 
USE university;

/*markdown
### пересоздаём таблицы
*/

DROP TABLE
  IF EXISTS study_groups,
  students,
  grades,
  teachers,
  subjects;

CREATE TABLE
  study_groups (
    group_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (group_id)
  );

CREATE TABLE
  teachers (
    teacher_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (teacher_id)
  );

CREATE TABLE
  subjects (
    subject_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (subject_id)
  );

CREATE TABLE
  students (
    student_id INT NOT NULL AUTO_INCREMENT,
    group_id INT NOT NULL,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (student_id),
    CONSTRAINT gr_st_id FOREIGN KEY (group_id) REFERENCES study_groups (group_id) ON UPDATE CASCADE ON DELETE CASCADE
  );

CREATE TABLE
  grades (
    grade_id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    teacher_id INT NOT NULL,
    subject_id INT NOT NULL,
    grade INT NOT NULL,
    PRIMARY KEY (grade_id),
    CONSTRAINT st_id FOREIGN KEY (student_id) REFERENCES students (student_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT te_id FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT su_gr_id FOREIGN KEY (subject_id) REFERENCES subjects (subject_id) ON UPDATE CASCADE ON DELETE CASCADE
  );

SHOW TABLES;

/*markdown
### заполняем таблицы
*/

INSERT INTO study_groups(name) VALUES ('К3-75Б'), ('К3-65Б'), ('ЛТ-1');

INSERT INTO students(group_id, name) VALUES (1, 'Адам Шехаб'), (1, 'Данил Маргарян'), (3, 'Вова Чумаченко');

INSERT INTO teachers(name) VALUES ('Ольга Юрьевна'), ('Анатолий Владимирович'), ('Александр Михайлович');

INSERT INTO subjects(name) VALUES ('Базы данных'), ('Дифференциальные уравнения'), ('Методы ООП');

INSERT INTO grades(student_id, teacher_id, subject_id, grade) VALUES 
    (1, 1, 3, 5), (2, 2, 1, 3), (3, 3, 3, 2);

/*markdown
### выводим содержимое таблиц
*/

SELECT * FROM students;
SELECT * FROM study_groups;
SELECT * FROM teachers;
SELECT * FROM subjects;
SELECT * FROM grades;

/*markdown
### запрос
*/

SELECT
    name
FROM
    students
WHERE
    student_id IN (
        SELECT
            student_id
        FROM
            grades
        WHERE
            grade = 2
    );

SELECT
    subjects.name AS subject_name,
    teachers.name AS teacher_name,
    students.name AS student_name,
    grade
FROM
    grades
    INNER JOIN students ON grades.student_id = students.student_id
    INNER JOIN teachers ON grades.teacher_id = teachers.teacher_id
    INNER JOIN subjects ON grades.subject_id = subjects.subject_id
WHERE
    grades.student_id IN (
        SELECT
            student_id
        FROM
            grades
        WHERE
            students.name LIKE 'Вова %'
    );

-- @DELIMITER $$

DROP PROCEDURE IF EXISTS pr_test$$

CREATE PROCEDURE pr_test()
BEGIN
    SELECT * FROM students;
END$$
-- @DELIMITER ;

CALL pr_test();

/*markdown
### созаем таблицу
*/

DROP TABLE IF EXISTS numbers;

CREATE TABLE numbers(
    number_id INT NOT NULL AUTO_INCREMENT,
    number VARCHAR(10) NOT NULL,
    PRIMARY KEY (number_id)
);

/*markdown
### создаем процедуру
*/

DROP TABLE IF EXISTS numbers;

CREATE TABLE numbers(
    number_id INT NOT NULL AUTO_INCREMENT,
    number VARCHAR(10) NOT NULL,
    PRIMARY KEY (number_id)
);

DROP PROCEDURE IF EXISTS pr_while;

-- @DELIMITER //  
CREATE PROCEDURE pr_while()   
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE st VARCHAR(10);
    WHILE (i <= 8) DO
        WHILE (j <= 6) DO
            SET st = 'К3-';
            SET st = CONCAT(st, i, j, 'Б');
            INSERT INTO numbers(number) VALUES (st);
        SET j = j+1;
        END WHILE;
        SET j = 1;
    SET i = i+1;
    END WHILE;
END;
-- @//  

CALL pr_while(); 
select * from numbers limit 10;
select * from numbers order by number_id DESC limit 10;




CREATE TABLE enrolle(
    enrolle_id INT NOT NULL AUTO_INCREMENT,
    name_enrolle VARCHAR(10) NOT NULL,
    PRIMARY KEY (number_id)
);

DROP TABLE IF EXISTS enrolle, program, program_enrolle;

CREATE TABLE enrolle(
    enrolle_id INT NOT NULL AUTO_INCREMENT,
    name_enrolle VARCHAR(30) NOT NULL,
    PRIMARY KEY (enrolle_id)
);

CREATE TABLE program(
    program_id INT NOT NULL AUTO_INCREMENT,
    name_program VARCHAR(30) NOT NULL,
    PRIMARY KEY (program_id)
);

CREATE TABLE program_enrolle(
    program_enrolle_id INT NOT NULL AUTO_INCREMENT,
    program_id INT NOT NULL,
    enrolle_id INT NOT NULL,
    PRIMARY KEY (program_enrolle_id),
    CONSTRAINT pr_id FOREIGN KEY (program_id) REFERENCES program (program_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT en_id FOREIGN KEY (enrolle_id) REFERENCES enrolle (enrolle_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DESC enrolle;
DESC program;
DESC program_enrolle;

