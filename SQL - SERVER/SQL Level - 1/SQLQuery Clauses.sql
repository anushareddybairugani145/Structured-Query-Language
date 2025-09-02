--Retrive All Custmer Data
SELECT *
FROM customers


--Retrive All orders Data
SELECT*
FROM orders

-- Retrive each customer name, country,and score

SELECT
	first_name,
	country,
	score
FROM  customers

--Retrive customers with a score not equal to 0

SELECT *
FROM customers 
WHERE score !=0

SELECT *    --if we dont want score here then mention first_name,country
FROM customers
WHERE country = 'Germany'

--Retrive all customer and sort result by the highest score first
--the default order for ORDER BY is ASC (ascending).

SELECT*
FROM customers
ORDER BY score DESC --ASC

--Nested Order by 
---Retrive all customers and sort the results by the country and then by the highest score

SELECT*
FROM customers
order by country ASC,
         score DESC

--GROUP BY 
--Find the total score for each country
SELECT
	country,
	SUM(score) AS total_score
FROM customers
group by country

--find the total score and total number of customers for each country
SELECT 
	SUM(score) AS total_score,
	count(id) AS total_customers
FROM customers 
group by country

--Having 
--find the average score for each country considering only customers with a score not equal to 0 
--and return only those countries with an average score greater than 430

SELECT 
    country,
    AVG(score) AS average_score
FROM customers
WHERE score != 0
GROUP BY country
Having   AVG(score) > 430

--DISTINCT
--return unique list of all countires

SELECT DISTINCT
     country
FROM customers

--TOP
--retrive only 3 customers

SELECT TOP 3*
FROM customers

--retrive the top 3 cuustoers with the highest scores

SELECT TOP 3*
FROM customers
ORDER BY score DESC

--retrive the lowest 2 customers based on score

SELECT TOP 2*
FROM customers 
ORDER BY score ASC

---Get the two most recent orders
SELECT TOP 2*
FROM orders
ORDER BY order_date DESC


--coding order select to order by
-- execution order FROM - WHERE GROUP BY - HAVING - SELECT DISTINCT - ORDER BY - Top.


--Multi - Queries

SELECT *
FROM customers 

SELECT*
fROM orders

--Static (fixed) values
SELECT 123 AS static_number

SELECT
id, 
country,
score,
'games' AS game_name
FROM customers 

--highlight and Execute
SELECT *
FROM customers
Where country = 'Germany'





