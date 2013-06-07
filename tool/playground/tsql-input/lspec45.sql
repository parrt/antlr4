USE AdventureWorks ;
GO
SELECT pm.Name AS ProductModel, p.Name AS ProductName, SUM(OrderQty)
FROM Production.ProductModel pm
INNER JOIN Production.Product p 
ON pm.ProductModelID = p.ProductModelID
INNER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID 
GROUP BY pm.Name, p.Name
WITH ROLLUP ;
GO

