--DDL CREATE ALTER DROP 
--DML INSERT UPDATE DELETE

-- INSERT SYNTAX 
--insert into table_name (col1,col2,col3)
--values(val1,val2,val3)


--INSERT INTO customers(id,first_name,country,score)
--values (7,'sahana','India',100)
--(6,'Anusha','India',NULL),
--SELECT * FROM customers


--copy data from customers table into persons
--source table is customers and target table is persons
INSERT INTO persons (id ,person_name, birth_Date, email)
SELECT 
id,
first_name,
NULL,
'UNKNOW'
FROM customers 
SELECT * FROM persons



--update syntax
--update table_name
-- set col1 = value1,
--     col2 = value2
--where <condition>

--change the score of customer with ID 6 TO 0
UPDATE customers 
  set score = 0
WHERE id  =	 6

SELECT * FROM customers
WHERE id = 6

--change the score of custommer with id 7 to 0 and update the country to uk 

update customers
set score = 0,
    country = 'uk'
WHERE id = 7

SELECT *FROM customers
WHERE id = 7
 

update customers 
set score = 100
select * from customers

update customers 
set score = NULL
WHERE id = 3
select * from customers
where id = 3


--update all customers with NULL score by setting their score to 0
UPDATE customers 
set score = 0
WHERE score IS NULL

select* from customers 
WHERE score IS NULL

--DELETE SYNTAX 
--DELECT FROM table_name 
--where<condition>

--Delect all customers with an id greater than 5 
DELETE FROM customers 
where id > 5


select * from customers 
where id > 5 

--DELETE THE DATA FROM THE TABLLE PERSONS
--TRUNCATE CLEARS THE WHOLE TABLE AT ONCE WITHOUT CHECKING OR LOGGING

--TRUNCATE TABLE persons if we executes this whole dat will be clear 




