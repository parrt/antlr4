USE AdventureWorks ;
GO
SELECT ProductModelID, GROUPING(ProductModelID), p.Name AS ProductName, GROUPING(p.Name), SUM(OrderQty)
FROM Production.Product p 
INNER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID 
GROUP BY ProductModelID, p.Name
WITH CUBE ;
GO

