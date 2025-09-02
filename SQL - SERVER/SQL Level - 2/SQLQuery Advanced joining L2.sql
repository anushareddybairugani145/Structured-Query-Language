--using salesDB , retrive a list of all orders, aloneg with related customers , product, and employee details.
-- for each order, display:
--order id , customer's name ,product name , sale amount,Product prize , sakesperson's name 

SELECT 
	o.OrderID,
	o.Sales,
	c.firstName AS CustomerFirstName ,
	c.LastName AS CustomerLastName,
	p.Product AS ProductName,
	p.Price,
	e.FirstName AS EMPLOYEEFirstName,
	e.LastName AS EmployeeLastName
FROM Sales.Orders AS O
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p 
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID





--using salesDB , retrive a list of all orders, aloneg with related customers , product, and employee details.
-- for each order, display:
--order id , customer's name ,product name , sale amount,Product prize , sakesperson's name 

--SELECT * FROM Sales.Customers 
--SELECT * FROM Sales.Employees
--SELECT * FROM Sales.Orders
--SELECT * FROM Sales.OrdersArchive
--SELECT * FROM Sales.Products


SELECT 
o.OrderID AS ORDERID,
o.Sales,
c.FirstName AS CustomerFirstName,
c.LastName AS CustomerLastName,
p.Product AS ProductName ,
p.price,
e.FirstName AS EmployeeFirstName,
e.LastName AS EmployeeLastName
FROM Sales.Orders AS o 
LEFT JOIN  Sales.Customers  AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p 
ON o.ProductID = p.ProductID
Left Join  Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID

