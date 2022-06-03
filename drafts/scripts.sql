/*markdown
# Скрипты
*/

/*markdown
### Новая колонка, копирование данных из старой, удаление старой, добавление нового ключа к новой колонке
*/

-- # FIX Почему в разнобой порядок колонок

-- Добавляем колонку
ALTER TABLE trip_1 ADD id_comp_1 INT NOT NULL;
-- Копируем старую колонку в новую
UPDATE trip_1 SET id_comp_1=id_comp;

-- Говорим что в стврой  колонке может быть NULL
ALTER TABLE trip_1 MODIFY id_comp INT;
-- Зануляем старую колонку
UPDATE trip_1 SET id_comp=NULL;

-- Дропаем старый ключ
ALTER TABLE trip_1 DROP CONSTRAINT FK_trip_company_1;
-- Дропаем старую колонку
ALTER TABLE trip_1 DROP id_comp; 

-- Добавляем ключ к новой колонке
ALTER TABLE trip_1 ADD CONSTRAINT FK_trip_company_1 FOREIGN KEY (id_comp_1) REFERENCES company_1(id_comp) ON DELETE CASCADE;
-- Переименовываем новую колонку в старую
ALTER TABLE trip_1 RENAME COLUMN id_comp_1 TO id_comp;

/*markdown
### Каскадное удаление (демонстрация) + транзакции
*/

-- отключаем автокоммит в бд
set autocommit=0;
Start transaction;

-- Каскадное удаление (Пример)
SELECt * FROM company_1;
DELETE FROM company_1 WHERE id_comp = 4;
SELECt * FROM company_1;
SELECT * FROM trip_1;

-- откатываем изменения
rollback;