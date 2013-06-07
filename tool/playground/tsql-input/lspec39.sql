USE AdventureWorks ;
GO
SELECT ProductModelID, p.Name AS ProductName, SUM(OrderQty)
FROM Production.Product p 
INNER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID 
GROUP BY ProductModelID, p.Name
WITH CUBE ;
GO

