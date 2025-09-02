
--SQL FUNTIONS 
/* Functions :  A built-in SQL code:
--accepts an input value
--processes it
-- returns an output value
1. Single - Row functions (LOWER) SINGLE WORD
2. Multi - Row Functions (SUM) MORE NUMBER TO SUM
NESTED FUNCTIONS
functions used inside another functions.

--Row - level Funtion (ROW- LEVEL -CALCULATIONS)
--String Funtions , Number Functions , Date & Time Functions , Null Functions , Case Statement 

--Multi-Row Functions (AGGREGATIONS)
--Aggregate Functions(Basics) Window Functions (Advanced)
*/

/*String functions
a. manipulation : concat, upper,lower,trim,replace
b. calculation : len
c.string extraction : left,right,substring*/

--CONCAT : combine multiple strings into one.
--concatenate first name and country intp one column

SELECT  
first_name,
country,
CONCAT(first_name, '_ ' ,country) AS name_country
FROM customers

--UPPER : converts all characters to upper case 
--LOWER : convert all characters to lower case
-- convert the first name to lowercase
SELECT  
first_name,
country,
CONCAT(first_name, '_ ' ,country) AS name_country,
LOWER(first_name) as lower_name,
--convert the first name to uppercase
UPPER(first_name) as upper_name
FROM customers

--TRIM() : removes leading and trailing spaces
--find ccustomers whose firstname contains leading or trailing spaces

SELECT  
first_name,
len(first_name) as len_firstname,
len(TRIM(first_name)) as lentrim_firstname,
len(first_name) - len(TRIM(first_name)) as flag
--CONCAT(first_name, '_ ' ,country) AS name_country,
--TRIM(first_name) as  trim_name
FROM customers
--where first_name != TRIM(first_name)
where len(first_name) != len(TRIM(first_name)) 

--REPLACE : replace specific character with a new character
--remove dashes (-) from a phone number 
Select
'1234-5678-9012',
REPLACE('1234-5678-9012', '-','') AS clean_phonenum

--replace file extence from txt to csv 
SELECT
'report.txt' AS OLD_file,
REPLACE('report.txt', '.txt','..csv')  as new_file

--b. calculation : len -- counts how many characters 
--calculate the length of each customer's first name

SELECT 
first_name,
len(first_name) as len_firstname
from customers

--c.string extraction : left,right,substring*/
--left : extract specific numbers of characters from the start 
--Right : extract specific numbers of character from the end 

--retrive the first two characters of each firstname
--retrive the last two characters of each firstname

select 
first_name,
left (TRIM (first_name ), 2) as first_2char,
RIGHT (first_name , 2) as last_2char
from customers 

--SUBSTRING:extract  a part of string at a specified  position
select 
'anushareddybairugani',
SUBSTRING('anushareddybairugani' , 1 , len('anushareddybairugani'))


select 
first_name,
substring(TRIM(first_name), 2 , len(first_name)) AS sub_name
from customers

--Number Functions : ROUND , ABS , DATA & TIME
select 
3.516,
ROUND(3.516,2) AS round_2,
ROUND(3.516,1) AS round_1,
ROUND(3.516,0) AS round_0

SELECT
-10,
ABS(-10),
ABS(10)

/*--DATE AND TIME FUNCTION
--1. DATE COLUMN FROM A TABLE
--2. HARDCODED CONSTANT STRING VALUE
--3.GETDATE() FUNCTION (RETURNS THE CURRENT DATE AND TIME AT THE MOMENT WHEN THE QUERY IS EXCUTED.)
SELECT
GETDATE()

PART EXTRACTION : day,month,year,datepart,datename,datetrunc,emonth
FORMAT AND CASTING : format,convert,cast
CALCULATION : dateadd,datediff
VALIDATION : isdate.*/

--PART EXTRACTION : day,month,year,datepart,datename,datetrunc,emonth

SELECT
OrderID,
CreationTime,
--DATETRUNC() TRUNCATES THE DATE TO SPECIFIC PART
DATETRUNC(MINUTE,CreationTime) as datetrunc_min,
DATETRUNC(HOUR,CreationTime) as datetrunc_hour,
DATETRUNC(MONTH,CreationTime) as datetrunc_month,
DATETRUNC(DAY,CreationTime) as datetrunc_day,
--DATENAME() RETURNS THE NAME OF A SPECIFIC PART OF A DATE 
DATENAME(YEAR, CreationTime) as datename_year,
DATENAME(MONTH , CreationTime) as datename_month,
DATENAME(day , CreationTime) as datename_day,
DATENAME(WEEKDAY , CreationTime) as datename_weekday,
DATENAME(quarter , CreationTime) as datename_quarter,
--DATEPART() RETURNS A SPECIFIC PART OF DATE AS A NUMBER
DATEPART(YEAR, CreationTime) as datepart_year,
DATEPART(MONTH, CreationTime) as datepart_month,
DATEPART(DAY, CreationTime) as datepart_day,
DATEPART(hour, CreationTime) as datepart_hour,
DATEPART(QUARTER, CreationTime) as datepart_quarter,
DATEPART(week, CreationTime) as datepart_weekday,

DAY(CreationTime) as day_ct,
Month(CreationTime) as month_ct,
year(CreationTime) as year_ct
from Sales.orders

--YEAR - MONTH-DAY-HOUR-MINUTES-SECONDS

--EOMONTH() - RETURNS THE LAST DAY OF A MONTH 
select
OrderID,
CreationTime,
EOMONTH(CreationTime) as endofthemonth,
CAST(DateTrunc(month , CreationTime) as Date )startofmonth
from Sales.orders

--How many orders were placed each year?
SELECT 
YEAR(OrderDate) AS year,
COUNT(*) NOOFORDERS
FROM Sales.Orders
Group  By YEAR(OrderDate)

--How many orders were placed each Month?
SELECT 
DATENAME(Month,OrderDate)  AS Month,
COUNT(*) NOOFORDERS
FROM Sales.Orders
Group  By DATENAME(Month,OrderDate)

--Show all orders that were placed during the month of february
SELECT *from Sales.Orders
WHERE MONTH(OrderDate) = 2
--Filtering data using an integer is faste rthan using a string

/* 
DATA TYPES 
DATEPART  -> INT 
DATENAME -> STRING
DATETRUNC -> DATETIME
EOMONTH -> DATE

WHICH PART ?
DAY, MONNTH ? NUMERIC DAY() , MONTH
              FULL NAME DATENAME() 
	    YEAR? YEAR()  
	OTHER PART ? DEPART()
*/
 
--FORMAT AND CASTING : format,convert,cast
--YYYY-MM-dd HH-mm-ss data time format - International 
--MM-dd-YYYY USA 
--dd-MM-YYYY EUROPEAN 
-- SQL SERVER INTERNATIONAL STANDARDS
-- FORMATTING 
-- CHANGING THE FORMAT OF A VALUE FROM ONE TO ANOTHER CHANGING HOW THE DATA LOOKS 


--FORMAT : formats a date or time value
--FORMAT (VALUE, FORMAT [,CULTURE])

SELECT 
OrderID,
CreationTime,
FORMAT(CreationTime, 'dd-MM-yyyy') AS DATE,
FORMAT(CreationTime, 'dd') AS Dd,
FORMAT(CreationTime, 'ddd') AS Ddd,
FORMAT(CreationTime, 'dddd') AS Dddd,
FORMAT(CreationTime, 'MM') AS MM,
FORMAT(CreationTime, 'MMM') AS MMM,
FORMAT(CreationTime, 'MMMM') AS MMMM, 
FORMAT(CreationTime, 'yy') AS yy,
FORMAT(CreationTime, 'yyy') AS yyy
FROM Sales.Orders

--show creation time using following format 
--day wed jan q1 2025 12:34:56 pm

SELECT 
OrderID,
CreationTime,
DATENAME(WEEKDAY, CreationTime) as day , 
DATENAME(Month,CreationTime) as month , 
DATEPART(QUARTER,CreationTime)as quarter, 
year(CreationTime) as  year, 
FORMAT(CreationTime, 'HH-mm-ss')
from Sales.Orders

select 
OrderID,
CreationTime,
'DAY' + FORMAT(CreationTime, 'ddd MMM') + 'Q'
+ DATENAME(QUARTER, CreationTime) + ' ' +
FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS customformat
from Sales.orders


--convert : convert data types
select 
convert(INT , '123') as stoi,
CreationTime,
convert ( Date ,CreationTime) 
from Sales.Orders

--cast 
SELECT
CAST('2025-08-13' AS  DATE)

--CALCULATION : dateadd,datediff
--DATEADD: ADDS OR SUBTRACT A SPECIFIC TIME INTERVAL TO/FROM  A DATE
SELECT 
OrderDate,
DATEADD (year,2, OrderDate) AS TWOYEARSLATER,
DATEADD (month,2, OrderDate) AS twoMONTHSLATER,
DATEADD (DAY,-10, OrderDate) AS tendaysbefore
from Sales.Orders
--DATEDIFF : Find the difference between two dates.
SELECT
OrderDate,
ShipDate,
DATEDIFF(Year, OrderDate , ShipDate) as year,
DATEDIFF(month, OrderDate , ShipDate) as month,
DATEDIFF(day, OrderDate , ShipDate) as day
from Sales.Orders

select
datediff(year, '2002-12-25',getdate()) AS age
--find the average shipping duration in days for each month
select
month(OrderDate)
ShipDate,
avg(DateDIFF(day,OrderDate,ShipDate)) as duration
FROM sales.Orders
Group by month(OrderDate)

--find the number of days between each order and previous order
--Time Gap --Window FUN
select 
OrderID,
OrderDate as currentorderdate,
LAG(OrderDate) over (Order By OrderDate) AS  previousOrderDate,
DATEDIFF( DAY,LAG(OrderDate) over (Order By OrderDate),OrderDate) AS  noofdays
FROM Sales.Orders


--VALIDATION : isdate

--ISDATE() check if a value is a date. returns 1 if the string value is valid date
SELECT
ISDATE('2025-08-13'),
ISDATE('1233')


--NULL FUNCTIONS
--ISNULL : REPLACE NULL WITH A SPECIFIED VALUE
--COALESCE

-- find the average score of customers 
select 
CustomerID,
Score,
coalesce(Score,0) asscore2,
avg(Score) over() as avg_score,
avg(coalesce(Score,0)) over() asnull0
from Sales.Customers


/*display the full name of customers in a single field
by merging their first and last names,
and add 10 points to each customers score.
*/

select
FirstName,
LastName,
FirstName + coalesce(LastName,'') AS fullname,
Score,
Coalesce(Score , 0) + 10 as finalwithbonus
from Sales.Customers


--ISNULL
--Sort the customers from lowest to highest scores, with NULLS appearing last
SELECT 
Score
--COALESCE(Score, '9999999') --lazyway
--case when Score IS NULL THEN 1 ELSE 0 END
FROM Sales.Customers
ORDER BY case when Score IS NULL THEN 1 ELSE 0 END
 ASC 

 -- NULLIF() : NULLIF(VALUE1,VALUE2) --> NULLIF(Price, -1) --> -1 replaces with NULL
 -- COMPARE TWO EXPRESSION RETURNS:
 --NULL, IF THEY ARE EQUAL 
 -- FIRST VALUE, IF THEY ARE NOT EQUAL


--NULLIF 
--FIND THE SALES PRICE FOR EACH ORDER BY DIVIDING SALES BY QUANTITY
select
OrderID,
Sales,
Quantity,
Sales / NULLIF(Quantity,0) AS Price
from Sales.Orders

--IS NULL : RETURNS TRUE IF THE VALUE IS NULL
--OTHERWISE IT RETURNS FALSE.

--IS NOT NULLL
--RETURNS TRUE IF THE VALUE IS NOT NULL
--OTHERWISE IT RETURNS FALSE.


--IDENTIFY THE CUSTOMERS WHO HAVE NO SCORE 
SELECT
CustomerID,
Score
FROM Sales.Customers
WHERE Score IS NULL

--List all customers who have score 
select * From Sales.Customers
WHERE Score is not null

--left anti join and right anti join use case 
-- finding the unmatched row between two tables
--list all details for customers who have not placed any orders

SELECT c.* ,
o.OrderID
FROM Sales.Customers as c
LEFT JOIN Sales.Orders as o
ON c.CustomerID = O.CustomerID
WHERE o.CustomerID IS NULL


WITH ORDERS AS (
SELECT 1 ID, 'A' CATEGORY UNION
SELECT 2,  NULL UNION
SELECT 3,  '' UNION
SELECT 4,  '  '
)
SELECT * ,
LEN(CATEGORY) as len,
NULLIF(Trim(CATEGORY),'') AS POLICY2,
trim(CATEGORY) AS POLICY1,
COALESCE(NULLIF(Trim(CATEGORY),''), 'UNKNOW') AS POLICY3
FROM ORDERS


--DATA POLICY 
--set of rules that defines how data should be handled,
-- 1. only usa NULLs and empty strings, but avoid blank spaces.
--2.only use NULLs and avoid using empty strings and blank spaces.
--3.use DEFAULT Values 'unknown' and avoid using nulls, empty strings, blank spaces.



--CASE STATEMENT
--GENGENERATE A REPORT SHOWING THE TOTAL SALES FOR EACH CATEGORY:
--HIGH : IF SALES HIGHER THAN 50
--MEDIUM:IF THE SALES BETWEEN 20 AND 50 
---LOW:IF THE SALES EQUAL OR LOWER THAN 20 
--SORT THE RESULT FROM highest TO lowest

SELECT 
Category,
SUM(Sales) as totalSales
FROM( 
	 SELECT
	  OrderID,
	  Sales,
	  CASE 
		  WHEN Sales > 50  then 'HIGH'
		  WHEN Sales between 20 and 50 then 'MEDIUM'
		  ELSE 'LOW'
	  END Category
	  FROM Sales.Orders 
)t
group by Category
ORDER BY totalSales desc

---MAPPING 
--RETRIVE EMPLOYEE DETAILS WITH GENDER DISPLAYED AS FULL TEXT 

SELECT 
EmployeeID,
Gender,
case
    when Gender = 'M' then 'MALE'
    WHEN Gender = 'F' then 'FEMALE'
    END AS GENDERFULLTEXT
FROM Sales.Employees

--RETRIVE CUSTOMER DETAILS WITH ABBREVIATED COUNTRY CODE
SELECT * ,
case 
 when Country ='Germany' then 'DE'
 when Country ='USA'     then 'US'
END AS abbriavtedcode
FROM sales.Customers

--quick Form
SELECT * ,
case Country
 when 'Germany' then 'DE'
 when 'USA'     then 'US'
END AS abbriavtedcode
FROM sales.Customers


--handling nulls
--find the average score of customers and treat NULLS As o
--additionally provide details such CustomerID and LastName.
SELECT 
CustomerID,
LastName,
Score, 
avg(Score) over() avgCustomer,
case 
	  WHEN Score IS NULL THEN 0
	  else Score
 END as scoreclean,

 avg(case 
	  WHEN Score IS NULL THEN 0
	  else Score
 END ) over() avgggupdate
From Sales.Customers


--count how many times each customer has made an order with sales greater than 30 
SELECT  
CustomerID,
SUM(case 
    when Sales > 30 THEN 1
	ELSE 0
	END ) TotalOrdershighSales,
	count(*) TotalOrders

from Sales.Orders
Group by customerID