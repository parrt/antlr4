USE AdventureWorks ;
GO
-- By default, SQL Server performs an INNER JOIN if only the JOIN 
-- keyword is specified.
SELECT p.Name, sod.SalesOrderID
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID
ORDER BY p.Name ;


