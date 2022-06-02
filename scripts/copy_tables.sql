/*markdown
# Copy tables (2 options)
*/

/*markdown
## 1. (works) Create copy of tables (LIKE) -> Drop old keys from copied tables -> Create new keys
*/

-- Create copy of tables

DROP TABLE IF EXISTS company_1, passenger_1, trip_1, pass_in_trip_1;

CREATE TABLE IF NOT EXISTS trip_1 LIKE trip;
CREATE TABLE IF NOT EXISTS passenger_1 LIKE passenger;
CREATE TABLE IF NOT EXISTS company_1 LIKE company;
CREATE TABLE IF NOT EXISTS pass_in_trip_1 LIKE pass_in_trip;

-- Insert data

INSERT INTO company_1 SELECT * FROM company;
INSERT INTO trip_1 SELECT * FROM trip;
INSERT INTO passenger_1 SELECT * FROM passenger;
INSERT INTO pass_in_trip_1 SELECT * FROM pass_in_trip;

-- Remove old keys

ALTER TABLE company_1 DROP PRIMARY KEY;
ALTER TABLE trip_1 DROP PRIMARY KEY;
ALTER TABLE passenger_1 DROP PRIMARY KEY;
ALTER TABLE pass_in_trip_1 DROP PRIMARY KEY;

ALTER TABLE trip_1 DROP INDEX FK_trip_company;
-- #? LOl why this FK didnt copy?...
-- ALTER TABLE pass_in_trip_1 DROP INDEX FK_pass_in_trip_trip;
ALTER TABLE pass_in_trip_1 DROP INDEX FK_pass_in_trip_passenger;

-- Add keys to new tables

-- PK
ALTER TABLE company_1 ADD CONSTRAINT PK2 PRIMARY KEY CLUSTERED (ID_comp);   
ALTER TABLE trip_1 ADD CONSTRAINT PK_t PRIMARY KEY  CLUSTERED (trip_no);   
ALTER TABLE passenger_1 ADD CONSTRAINT PK_psg PRIMARY KEY CLUSTERED (ID_psg);   
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT PK_pt PRIMARY KEY  CLUSTERED (trip_no, date, ID_psg);   

-- FK
-- #? Cant have same constraint name in different tables? (FK_trip_company_1 and FK_trip_company)
ALTER TABLE trip_1 ADD CONSTRAINT FK_trip_company_1 FOREIGN KEY (ID_comp) REFERENCES company_1(ID_comp);
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT FK_pass_in_trip_trip_1 FOREIGN KEY (trip_no) REFERENCES trip_1(trip_no);
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT FK_pass_in_trip_passenger_1 FOREIGN KEY (ID_psg) REFERENCES passenger_1(ID_psg);

/*markdown
## 2. (works) Option (no LIKE): Copy tables with only data -> Create new relations
*/

-- Copy tables

DROP TABLE IF EXISTS company_1, passenger_1, trip_1, pass_in_trip_1;

CREATE TABLE trip_1 AS SELECT * FROM trip;
CREATE TABLE company_1 AS SELECT * FROM company;
CREATE TABLE passenger_1 AS SELECT * FROM passenger;
CREATE TABLE pass_in_trip_1 AS SELECT * FROM pass_in_trip;

-- Add keys to new tables

-- PK
ALTER TABLE company_1 ADD CONSTRAINT PK2 PRIMARY KEY CLUSTERED (ID_comp);   
ALTER TABLE trip_1 ADD CONSTRAINT PK_t PRIMARY KEY  CLUSTERED (trip_no);   
ALTER TABLE passenger_1 ADD CONSTRAINT PK_psg PRIMARY KEY CLUSTERED (ID_psg);   
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT PK_pt PRIMARY KEY  CLUSTERED (trip_no, date, ID_psg);   

-- FK
-- #? Cant have same constraint name in different tables? (FK_trip_company_1 and FK_trip_company)
ALTER TABLE trip_1 ADD CONSTRAINT FK_trip_company_1 FOREIGN KEY (ID_comp) REFERENCES company_1(ID_comp) ON DELETE CASCADE;
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT FK_pass_in_trip_trip_1 FOREIGN KEY (trip_no) REFERENCES trip_1(trip_no) ON DELETE CASCADE;
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT FK_pass_in_trip_passenger_1 FOREIGN KEY (ID_psg) REFERENCES passenger_1(ID_psg) ON DELETE CASCADE;