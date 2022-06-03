/*markdown
# Copy tables
*/

/*markdown
## Copy tables with data but without relations
*/

-- Copy tables

DROP TABLE IF EXISTS company_1, passenger_1, trip_1, pass_in_trip_1;

CREATE TABLE trip_1 AS SELECT * FROM trip;
CREATE TABLE company_1 AS SELECT * FROM company;
CREATE TABLE passenger_1 AS SELECT * FROM passenger;
CREATE TABLE pass_in_trip_1 AS SELECT * FROM pass_in_trip;

/*markdown
## Create new relations
*/

-- Add keys to new tables

-- PK
ALTER TABLE company_1 ADD CONSTRAINT PK2 PRIMARY KEY CLUSTERED (ID_comp);   
ALTER TABLE trip_1 ADD CONSTRAINT PK_t PRIMARY KEY  CLUSTERED (trip_no);   
ALTER TABLE passenger_1 ADD CONSTRAINT PK_psg PRIMARY KEY CLUSTERED (ID_psg);   
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT PK_pt PRIMARY KEY  CLUSTERED (trip_no, date, ID_psg);   

-- FK
ALTER TABLE trip_1 ADD CONSTRAINT FK_trip_company_1 FOREIGN KEY (ID_comp) REFERENCES company_1(ID_comp) ON DELETE CASCADE;
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT FK_pass_in_trip_trip_1 FOREIGN KEY (trip_no) REFERENCES trip_1(trip_no) ON DELETE CASCADE;
ALTER TABLE pass_in_trip_1 ADD CONSTRAINT FK_pass_in_trip_passenger_1 FOREIGN KEY (ID_psg) REFERENCES passenger_1(ID_psg) ON DELETE CASCADE;

/*markdown
## Check if tables are copied
*/

SHOW TABLES;