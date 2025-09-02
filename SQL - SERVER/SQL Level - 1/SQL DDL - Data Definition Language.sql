--DDL Data Definition Language

/*create a new table called persons
with column:id, person_name,birth_date,and phone*/

CREATE TABLE persons(
	id INT NOT Null,
	person_name VARCHAR(50) NOT NULL,
	birth_Date DATE,
	phone VARCHAR(15)NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
)
SELECT * fROM persons

-- ADD EMAIL TO TABLE PERSONS
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL
SELECT * fROM persons

--remove th column phone from the person table
ALTER TABLE persons
DROP COLUMN phone
SELECT * FROM persons

--Delect the table from the database
--DROP TABLE persons
