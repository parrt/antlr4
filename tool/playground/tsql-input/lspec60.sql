USE AdventureWorks;
GO
SELECT 'The order is due on ' + CONVERT(varchar(12), DueDate, 101)
FROM Sales.SalesOrderHeader
WHERE SalesOrderID = 50001;
GO
