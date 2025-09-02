--WHERE OPERATOR 
--Comparision operator, logical operator , range operator,membership operator, search operator.

--comparison operator 
--expression operator expression - condition

--Retrive all customers from germany  (=)
SELECT * FROM customers
WHERE country = 'Germany'
--Retrive all customers who are not from germany (!=)
SELECT * FROM customers
WHERE country != 'Germany'
--Retrive all customers with score greater than 500 (>)
SELECT * FROM customers 
WHERE score > 0
--Retrive all customers with a score of 500 or more (>=)
SELECT * FROM customers 
WHERE score >= 100
--Retrive all customers with a score less than 500 (<)
SELECT * FROM customers 
Where score  < 200
--Retrive all customers with a score of 500 or less (<=)
SELECT *FROM customers 
WHERE score <= 100

--Logical Operator 
--AND ALL CONDITION MUST BE TRUE 

--Retrive all customers who are from the usa AND have a score greater than 500 
SELECT * FROM customers 
WHERE country = 'USA' AND score > 0

--OR atleast one condition must be true 
--Retrive all customers who are either from the usa OR have a score greater than 500
SELECT * FROM customers 
WHERE country = 'USA' OR score > 0

--NOT (Reverse) excludes matching values 
--Retrive all customers with a score NOT less than 500
SELECT *FROM customers 
WHERE NOT score < 0

--Between check is a value with in a range 
--Retrive  all customers whose score falls in the range between 0 and 100
SELECT * FROM customers 
WHERE score Between 0 and 100

--membership operator 
--IN check if a value exists in a list 
--Retrive all customers from eiither germany or usa
SELECT * FROM customers
Where COUNTRY = 'Germany' OR country = 'USA'

SELECT * FROM customers 
WHERE country IN ('Germany','USA')

SELECT * FROM customers 
WHERE country  NOT IN ('Germany','USA')

--SEARCH OPERATOR LIKE OPERATOR SEARCH FOR A PATTERN IN TEXT
-- (- EXACT % -ANYTHING)
--FIND ALL CUSTOMERS WHOSE FIRST NAME STARTS WITH M
SELECT * FROM customers 
WHERE first_name LIKE 'M%'

--FIND ALL CUSTOMERS WHOSE FIRST NAME ENDS WITH N
SELECT * FROM customers 
WHERE first_name LIKE '%N'

--find all customers whose first name contains 'r'
SELECT * FROM customers 
WHERE first_name LIKE '%r%'

--find all customers whose first name has 'r' in the thid position
SELECT * FROM customers 
WHERE first_name LIKE '__r%'


