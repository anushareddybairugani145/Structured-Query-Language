--Aggreation Function
--Find the total number of orders
--find the total sales of all orders 
--FIND THE HIGHEST SCORE AMONG CUSTOMERS 
--find the average sales of all orders
SELECT 
Customer_ID,
COUNT(*) AS Total_orders,
SUM(Sales) AS Total_Sales,
MAX(Sales) AS Highesteofsales,
MIN(Sales) AS Lowestofsales,
AVG(Sales) AS averageofsales
FROM Orders
GROUP BY Customer_ID


--window Basics
--window vs group by
--FIND THE TOTAL SALES FOR EACH PRODUCT 
--ADDITIONALLY PROVIDE DETAILS SUCH ORDER ID , ORDER DATE

SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY PRODUCTID) AS TOTALSALESOFEP
FROM Sales.Orders

--GROUPBY --SIMPLE DATA ANALYSIS (Aggregations)
--WINDOW  --ADVANCED DATA ANALYSIS (AGGREGATIONS + Details)
--syntax window</>
--1.window functionf(x) 2.over clause a.partitionclause,b.orderclause,c.frameclause
/*Partition 
Partitionby(without partition by ) total sales all rows.
single column--total sales for each product
combined columns --total sales for each combination of product and order status
*/

--find the total sales accross all orders aditionally provide details 
--such order id and order date


SELECT
OrderID,
OrderDate,
sum(Sales) OVER()
FROM Sales.Orders

--find the total sales for each product aditionally provide details 
--such order id and order date

SELECT
OrderID,
OrderDate,
ProductID,
sum(Sales) OVER(PARTITION BY ProductID)
FROM Sales.Orders
--find the total sales for each combination of product and order status

SELECT
ProductID,
OrderStatus,
sum(Sales) over (partition by productID,OrderStatus)
from Sales.Orders

--rank each order based on their sales from highest to lowest, additionally provide details such order id and order date

SELECT
OrderID,
OrderDate,
Sales,
Rank() Over(ORDER BY Sales DESC)
FROM Sales.Orders

--WINDOW FRAME
--DEFINES A SUBSET OF ROWS WITHIN EACH WINDOW THAT IS RELEVANT FOR THE CALCULATION
SELECT 
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) over(partition by OrderStatus Order BY OrderDate 
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING ) TotalSales
FROM SALES.Orders 


--rules 4x
-- 1.window function can be used only in select and order by clause.
--2.nesting window function is not allowed!
--3.sql excutes window function after where clause
--4.window function can be used together with group by
--in the same query, only if the same columns are used

--Window Aggregate. to be continued.

--Aggregate functions 
--COUNT,SUM,AVG,MIN,MAX

--COUNT () returns the number of rows within a window
--count(*) counts all the rows in a table, regardless of whether any value is NULL
--find the total number of orders
 SELECT 
 COUNT(*) AS TOTALORDRS
 FROM Sales.Orders

 --find the total number of orders
 --find the total number of orders for each customers
--additionally provide details such order id and orderr date
 SELECT 
 OrderID,
 OrderDate,
 CustomerID,
 COUNT(*) OVER() AS TOTALORDRS,
 COUNT(*) OVER(PARTITION BY CustomerID) ordersbycustomers
 FROM Sales.Orders

 --find total number of customers 
 --find the total number of scores for the customers
 --additionally provide all customers details

 SELECT
 *,
 COUNT(*) OVER() AS TOTALCUSTOMERS,
 COUNT(Score) over() AS TOTALSCORE,
 COUNT(Country) OVER() AS TOTALCOUNTRIES,
  COUNT(LastName) OVER() AS TOTALLastName

 FROM Sales.Customers

 --DATA QUALITY ISSUE
 -- duplicates lead to inaccuracies in analysis
 ---count() can be used to identifiy duplicates
 --check wheather the table 'orders' contains any duplicate rows

 SELECT 
  OrderID,
  COUNT(*) OVER (PARTITION BY OrderID) AS checkdp
 FROM Sales.Orders

 SELECT 
  OrderID,
  COUNT(*) OVER (PARTITION BY OrderID) AS checkpk
 FROM Sales.OrdersArchive

 SELECT * FROM(
  SELECT 
  OrderID,
  COUNT(*) OVER (PARTITION BY OrderID) AS checkpk
 FROM Sales.OrdersArchive
 )t WHERE checkpk > 1

 /*  count use cases 
 overall analysis 
 category analysis
 quality checks: identify NULLs
 Quality checks: identify duplicates*/

--SUM : Returns the sum of values within a window
--find the total sales across all orders and the total sales for each product. 
--additionally, provide details such as order ID and order date.

SELECT 
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER() AS TOTALSALES,
SUM(Sales) OVER(PARTITION BY ProductID) AS TOTALSALESBYPRODUCT
FROM Sales.Orders

--COMPARISION USE CASES
--COMPARE THE CURRENT VALUE AND AGGREGATED VALUE OF WINDOW FUNCTIONS
--FIND THE PERCENTAGE CONTRIBUTION OF EACH PRODUCT'S SALES TO THE TOTAL SALES.

SELECT 
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() AS TotalSales,
round( cast( Sales AS FLOAT) / SUM(Sales) OVER() * 100,2) Percentage
FROM Sales.Orders

--AVG() returns the average of values within a window 
--find the average sales accross all orders and the average sales for each product.
--additionally, provide details such as orderID and order date.

SELECT 
OrderID,
OrderDate,
ProductID,
AVG(Sales) Over() AS Avgsales,
AVG(SALES) Over(PARTITION BY ProductID) AS AVGSALEBYPRODUCT
FROM Sales.Orders

--FIND THE average scores of customers. additionally,
--provide details such as customer ID and Last Name

SELECT 
CustomerID,
LastName,
Score,
COALESCE(Score,0) AS CUSTOMERSCORE,
AVG(Score) OVER() AVGSCORE,
AVG(COALESCE(Score,0)) OVER() AS AVGSCOREWITHOUTNULL
from Sales.Customers


--Find all orders where sales are higher  than the average sales across all orders.
  
SELECT *
FROM(
SELECT 
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) OVER() avgsales
FROM Sales.Orders
)t WHERE Sales > avgsales

---MIN/MAX
--MIN():RETURNS THE LOWEST VALUE WITHIN A WINDOW
--MAX():RETURNS THE HIGHEST VALUE WITHIN AWINDOW
--FIND THE HIGHEST AND LOWEST SALES OF ALL ORDERS
--FIND THE HIGHEST AND LOWEST SALES FOR EACH PRODUCT
--ADDITIONALLY PROVIDE DETAILS SUCH ORDER ID, order date

SELECT 
OrderID,
OrderDATE,
Sales,
ProductID,

MAX(Sales) OVER() AS HIGHESTSALESFORORDERS,
MIN(COALESCE(Sales,0)) OVER() AS LOWESTSALESFORORDERS,

MAX(Sales) OVER(Partition BY ProductID) AS HIGHESTSALESFORPRODUCT,
MIN(COALESCE(Sales,0)) OVER(Partition BY ProductID) AS LOWESTSALESFORPRODUCTS

from Sales.Orders

--show the employee who have the highest salarries
select * 
from(
	SELECT  *,
	MAX(Salary) OVER() maxsalary
	FROM Sales.Employees
)t where Salary = maxsalary

--calculation the deviation of each sale from both the minium and max sales amounts.
SELECT 
OrderID,
OrderDate,
ProductID,
Sales,
MAX(Sales) OVER() HighestSales,
MIN(Sales) OVER() LowestSales,
Sales - MIN(Sales) OVER() MINDEVIATION,
MAX(Sales) OVER() - Sales Maxdeviation
from Sales.Orders

--RUNNING AND ROLLING TOTAL
/*They aggregate srequence of members and the aggregation is updated
each time a new member is added.

running total: 
aggregate all values from the beginning upto the current point
without dropping off older data.

rolling total:
aggregate all values within a fixed time window (Eg.30days).
as new data is added, the oldest data point will be dropped.
*/

--calculate the moving average of sales for each product over time.
SELECT 
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) over(PARTITION by ProductID) avgbyproduct,
AVG(Sales) over(partition by ProductID order by OrderDate) movingAvg
from Sales.Orders

--calculate the moving average of sales for each product over time,
--including only the next order
SELECT 
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) over(PARTITION by ProductID) avgbyproduct,
AVG(Sales) over(partition by ProductID order by OrderDate) movingAvg,
AVG(Sales) over(partition by ProductID order by OrderDate  ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) ROLLINGAVG 
from Sales.Orders

--window ranking function to be continued....
--TYPES OF RANKS -- INTEGER BASED RANKING AND PERCENTAGE BASED RAANKING
--INTEGER BASED RANKING
--ROW_NUMBER() --ASSIGN A UNIQUE NUMBER TO EACH ROW . IT DOESN'TT HANDLE TIES.
--RANK THE ORDERS BASED ON THEIR SALES FROM HIGHEST TO LOWEST 

SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(order BY Sales DESC) AS SALESRANK_ROW,
RANK() OVER(ORDER BY Sales DESC) SALESRANK_RANK,
DENSE_RANK() OVER(ORDER BY Sales DESC) AS DENSERANK_RANK
FROM Sales.Orders

--RANK() -- ASSIGN A RANK TO EACH ROW. 
--IT HANDLES TIES.
--IT LEAVES GAPS IN RANKING
--RANK() OVER(ORDER BY Sales DESC) SALESRANK_RANK

--DENSE_RANK
--ASSIGN A RANK TO EACH ROW 
--IT HANDLES TIES
--IT DOESN'T LEAVES GAPS IN RANKING
--DENSE_RANK() OVER(ORDER BY Sales DESC) AS DENSERANK_RANK

--COMPARISON
-- ROW_NUMBER() -- UNIQUE RANK -- DOES NOT HANDLE TIES -- NO GAPS IN RANKS
--RANK() -- SHARED RANK -- HANDLES TIES -- GAPS IN RANKS
--DENSE_RANK -- SHARED RANK--HANDLE TIES --- NO GAP IN RANKS


--TOP-N ANALYSIS -- ANALYSIS THE TOP PERFORMERS TO DO TARGETED MARKETING
--FIND THE TOP HIGHEST SALES FOR EACH PRODUCT 

select *
from(
SELECT 
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RANKBYPRODUCT
FROM Sales.Orders
)t where RANKBYPRODUCT = 1


--BOTTOM-N ANALYSIS -- HELP ANALYSIS THE UNDERPERFORMANCE TO MANAGE RISKS AND TO DO OPTIMIZATIONS
--FIND THE LOWEST 2 CUSTOMERS BASED ON THEIR TOTAL SALES 

select * 
from (
SELECT 
	CustomerID,
	SUM(Sales) as totalsales,
	ROW_NUMbER() OVER(ORDER BY SUM(Sales)) as rankcustomers
from Sales.Orders
group by CustomerID
)t where rankcustomers <= 2

--generate unique IDs
--ASSIGN UNIQUES IDS HELP TO ASSIGN UNIQUE IDENTIFIER FOR EACH ROW TO HELP PAGINATING
--assign uniques ids to the row of orders archive table
--paginating : the process of brreaking down a large data into smaller, more manageable chunks


SELECT 
ROW_NUMBER() OVER(ORDER BY OrderID,OrderDate) UniqueID,
*FROM Sales.OrdersArchive

--identify duplicates
--identify and remove duplicate row to improve data quality
--identify duplicate rows in the table orders archive and returns a clean result without any duplicates
SELECT * FROM(

SELECT 
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER  by CreationTime DESC) rn,
* 
from Sales.OrdersArchive

)t WHERE rn = 1

--NTILE -- DIVIDES THE ROW INTO A SPECIFIED NUMBRR OF APPROXIMATELYEQUAL GROUPS (BUCKETS)
SELECT 
OrderID,
Sales,
NTILE(1) OVER(ORDER BY Sales DESC) ONEBUSCKET,
NTILE(2) OVER(ORDER BY Sales DESC) twoBUSCKET,
NTILE(3) OVER(ORDER BY Sales DESC) threeBUSCKET,
NTILE(4) OVER(ORDER BY Sales DESC) fourBUSCKET
FROM Sales.Orders

--data segmentation
--divides a dataset into distinct subsets based on certain criteria
--segment all orders into 3 categories:
--high,medium, low sales

SELECT* ,
CASE Buckets 
   when 1 then 'high'
   when 2 then 'medium'
   when 3 then 'low'
end salessegmentation
from(
select 
OrderID,
Sales,
NTILE(3) OVER (ORDER BY Sales DESC) Buckets
from Sales.Orders
)t 

--equalizing load
--in order to export the data, divide the orders into 2 groups
select 
NTILE(2) OVER (ORDER BY OrderID) Buckets,
* from Sales.Orders

--percentage-based ranking
--cume_dist()--cumulative distribution calculate the distributio 
--of data point within a window -- cume_dist = position NR/ number of rows
--inclusive (the current row is included)

--percent_rank()
--calculates the relative position of each row
--percent_rank = position nr - 1 / number of rows - 1
--exclusive (the current row is excluded)

--find the products that fall within the highest 40% of prices

SELECT  * ,
CONCAT(DISTRANK *100, '%') DISTRANKPERCENTAGE
FROM (
select 
	product, 
	price,
	--CUME_DIST() over(Order BY Price DESC) AS DISTRANK
	PERCENT_RANK() over(Order BY Price DESC) AS DISTRANK

FROM Sales.Products
)T WHERE DISTRANK <= 0.4

 --VALUE WINDOW FUNCTION TO BE CONTINUED
 --LAG - PREVIOUS MONTH , LEAD -- NEXT MONTH
 --MONTH-OVER-MONTH ANALYSIS 
 --ANALYZE THE MONTH - OVER - MONTH PERFORMANCE BY FINDING THE PERCENTAGE CHANGE IS SALES BETWEEN THE CURRENT AND PREVIOUS MONTH.

 --TIME SERIES ANALYSIS 
 --a. year-over-year(yoy)
 --b. month-over-month(mom)

SELECT * ,
currentmonthsales -  Prevviousmonthsales AS MOM_CHANGE,
ROUND(CAST((currentmonthsales - Prevviousmonthsales) AS FLOAT) / Prevviousmonthsales *100 ,1) AS MOM_PERC
from(
 SELECT 
  MONTH(OrderDate) ORDERMONTH,
  SUM(Sales) currentmonthsales,
  LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) Prevviousmonthsales
 from Sales.Orders
 group by MONTH(OrderDate)
 )t

 --CUSTOMER RETENTION ANALYSIS
 --ANALYSE CUSTOMER LOYALTY BY RANKING CUSTOMERS BASED ON AVERAGE NUMBER OF DAYS BETWEEN ORDERS
Select 
customerID,
AVG(ddaysuntillnextorder) avgdays,
RANK() OVER (ORDER BY COALESCE (AVG(ddaysuntillnextorder),9999999)) Rankavg
from(
	 SELECT
	 OrderID,
	 CustomerID,
	 OrderDate CurrentOrder,
	 LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) nextorder,
	 DATEDIFF (DAY,OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) ddaysuntillnextorder
	 from Sales.Orders
 )t 
 group by CustomerID

 --firt_value() acess a value from the first row within a window.
 --last_value() acess a value from the last row within a window

 --find the lowest and highest sales for each product
 SELECT 
		 OrderID,
		 ProductID,
		 Sales,
		 MIN(Sales) OVER (PARTITION BY ProductID ) lowestmin,
		 MAX(Sales) OVER (PARTITION BY ProductID ) highestmax,
		 FIRST_VALUE(Sales) OVER(PARTITION BY ProductID Order By  Sales) lowestSales,
	     LAST_VALUE(Sales) OVER(PARTITION BY ProductID Order By  Sales
		 ROWS BETWEEN CURRENT ROW AND UNBOuNDED FOLLOWING) HighestSales,
		 FIRST_VALUE(Sales) OVER(PARTITION BY ProductID Order By  Sales DESC) HIGHESTSales,
		 Max(Sales) OVER (PARTITION BY ProductID ) -
		 Min(Sales) OVER (PARTITION BY ProductID ) As salesdifference
FROM Sales.Orders	