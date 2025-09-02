--SET Operators
--UNION
/*RULE 1  | SQL clauses
set operator can be used almost in all clauses WHERE , JOIN, GROUP BY, HAVING.
ORDER BY is allowed only once at the end of query
RULE 2  | Number of columns
the number of column in each query must be the same
RULE 3 | Data Types
data types of columns in eachh query must be compatible 
RULE 4 | Order Of Column
the order of the column in each query must be the same
RULE 5 | Column Aliases
the column name in the result set are determined by column names specified
in first query
RULE 6 | Correct Columns 
Even if all rules are met and sql shows no errors, the result may be incorrect.
incorrect column selection leads to inaccurate results.
*/

--Union 
--returns all district rows from both queries 
-- remove duplicate rows from the result.
--Combine the data from employees and customers into one table.

SELECT 
EmployeeID AS ID,
FirstName,
LastName
FROM Sales.Employees

UNION

SELECT
CustomerID,
FirstName,
LastName
FROM Sales.Customers

--Union All
--returns all rows from both queries , including duplicates
--COMBINE THE DATA FROM EMPLOYEES AND CUSTOMERS INTO ONE TABLE, INCLUDING DUPLICATES.
SELECT 
EmployeeID AS ID,
FirstName,
LastName
FROM Sales.Employees

UNION ALL

SELECT
CustomerID,
FirstName,
LastName
FROM Sales.Customers

--EXCEPT (MINUS)
--RETURNS ALL DISTINCT ROWS FROM THE FIRST QUERY THAT ARE NOT FOUND IN THE SECOND QUERY
--IT IS THE ONLY ONE WHERE THE ORDER OF QUERIES AFFECTS THE FINAL RESULT.
--FIND EMPLOYEES WHO ARE NOT CUSTOMERS AT THE SAME TIME.

SELECT 
FirstName,
LastName
FROM Sales.Employees

EXCEPT

SELECT
FirstName,
LastName
FROM Sales.Customers

--FIND Customers WHO ARE NOT Employees AT THE SAME TIME.

SELECT 
FirstName,
LastName
FROM Sales.Customers

EXCEPT

SELECT
FirstName,
LastName
FROM Sales.Employees


--INTERSECT
--Returns only the rows that are common in both quires
--find the employyes who are also customers.
SELECT 
FirstName,
LastName
FROM Sales.Customers

INTERSECT

SELECT
FirstName,
LastName
FROM Sales.Employees

/*COMBINE INFORMATION
combine similar information before analyzing the data
*/
 
--orders are stored in seperate tables (orders and orders Archive).
--combine all orders into one report without duplicates.

SELECT 
'Orders' AS SourceTable,
    OrderID,
	ProductID,
	CustomerID,
	SalesPersonID,
	OrderDate,
	ShipAddress,
	BillAddress,
	Quantity,
	Sales,
	CreationTime
FROM Sales.Orders
 
Union

SELECT
'OrdersArchive' AS SourceTable,
    OrderID,
	ProductID,
	CustomerID,
	SalesPersonID,
	OrderDate,
	ShipAddress,
	BillAddress,
	Quantity,
	Sales,
	CreationTime
FROM Sales.OrdersArchive

ORDER BY OrderID

--EXCEPT USE CASE
--Delta Detection (Example: id 1 and 2 add first day. then day 2 id 1 and id 3 given to source table. but in datawarehouse it takes only id3)
--identifying the differencddes or changes (delta) between two batches of data.
--Data Completeness check
---EXCEPT operator can be used to compare tables to detect discrepancies betee databases.

/*Summary 
1. combine the results of multiple quires into single result set
2. types union , union all, except , intersect.
3. rules : a.same no of columns , data types, orders of columns.
           b.1st query controls column names
4. use cases a. combines information(union , union all)
             b. delta dettectionn (Except)
			 c. data completeness checck (Excpet) same columns and row in table 1 and 2. result is empty.
