--Basic Joins
--NO Joins - returns data from tables without combininng Them
--TWO RESUTS NO NEED TO COMBINE

--RETRIVE ALL DATA FROM CUSTOMERS AND ORDERS AS SEPERATE RESULTS 

SELECT * FROM customers ;

SELECT * FROM ORDERS;

--Inner Join 
--default join is inner so we have to mention inner.j.
--return only matching rows from both tables 
-- get all customers along with their orders, but only for customers who have placed an order 

SELECT 
	c.id,
	first_name,
	order_id,
	sales
FROM customers AS c 
INNER JOIN  orders AS o
ON c.id =  o.customer_id 

--Left Join 
--Returns all rows from left and only matching from right 
--get all customers along with their orders, including those without orders 
SELECT 
	c.id,
	first_name,
	order_id,
	sales
FROM customers AS c 
Left JOIN  orders AS o
ON c.id =  o.customer_id 

--RIGHT JOIN
--Return all rows from right and only matching from left
--get all customers along with their orders, including orders without matching customers.
SELECT 
	c.id,
	first_name,
	order_id,
	sales
FROM customers AS c 
Right JOIN  orders AS o
ON c.id =  o.customer_id 

--alternative
--get all customers along with their orders, including orders without matching customers 
SELECT 
	c.id,
	first_name,
	order_id,
	sales
FROM orders AS o 
LEFT JOIN  customers AS c
ON c.id =  o.customer_id 

--full join Returns all rows from both tables
--get all customers and all orders, even if there's no match
SELECT 
	c.id,
	first_name,
	order_id,
	sales
FROM customers AS c
FULL JOIN  orders AS o
ON c.id =  o.customer_id 