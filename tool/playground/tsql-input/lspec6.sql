USE AdventureWorks ;
GO
SELECT 'Total income is', ((OrderQty * UnitPrice) * (1.0 - UnitPriceDiscount)), ' for ',
p.Name AS ProductName 
FROM Production.Product p 
INNER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID 
ORDER BY ProductName ASC ;
GO

