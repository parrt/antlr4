USE AdventureWorks;
GO
SELECT DATEDIFF(day, OrderDate, GETDATE()) AS NumberOfDays
FROM Sales.SalesOrderHeader;
GO

