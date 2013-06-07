USE AdventureWorks ;
GO
SELECT p.Name, sod.SalesOrderID
FROM Production.Product p
LEFT OUTER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID
ORDER BY p.Name ;


