--Left Anti Join
--returns row from left that has no match in right 

--get all customers who haven't placed any order

SELECT * 
FROM customers
LEFT JOIN orders 
ON customers.id = orders.customer_id
WHERE orders.customer_id IS NULL

select*from customers
select*from orders

--get all orders without matching customers
SELECT * 
FROM customers
RIGHT JOIN orders 
ON customers.id = orders.customer_id
WHERE customers.id IS NULL

--get all orders without matching customers
SELECT * 
FROM orders
left JOIN customers
ON customers.id = orders.customer_id
WHERE customers.id IS NULL

--full anti join returns only rows that dont match in either tables
SELECT * 
FROM customers
FULL JOIN orders 
ON customers.id = orders.customer_id
WHERE orders.customer_id IS NULL OR 
customers.id  IS NULL

--get all customers along with their orders, but only cusyommers who have placed an order

SELECT * FROM customers
LEFT JOIN orders 
ON customers.id = orders.customer_id
WHERE orders.customer_id IS NOT NULL 

--CROSS JOIN EVERY ROW AND EVRY COLUMN
--ALL POSSIBLE COMBINATIONS
--generate all posible combination of customers and orders 

SELECT * FROM CUSTOMERS
CROSS JOIN orders


--using salesDB , retrive a list of all orders, aloneg with related customers , product, and employee details.
-- for each order, display:
--order id , customer's name ,product name , sale amount,Product prize , sakesperson's name 

