USE AdventureWorks;
GO
SELECT DATEADD(day, 21, OrderDate)AS TimeFrame 
FROM Sales.SalesOrderHeader;
GO

