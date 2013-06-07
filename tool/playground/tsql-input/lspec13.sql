USE AdventureWorks ;
GO
SELECT DISTINCT c.LastName, c.FirstName 
FROM Person.Contact c JOIN HumanResources.Employee e
ON e.ContactID = c.ContactID WHERE EmployeeID IN 
(SELECT SalesPersonID 
FROM Sales.SalesOrderHeader
WHERE SalesOrderID IN 
(SELECT SalesOrderID 
FROM Sales.SalesOrderDetail
WHERE ProductID IN 
(SELECT ProductID 
FROM Production.Product p 
WHERE ProductNumber = 'BK-M68B-42'))) ;
GO

