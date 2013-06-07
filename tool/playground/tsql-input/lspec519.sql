USE AdventureWorks ;
GO
IF OBJECT_ID ('SalesPersonPerform', 'view') IS NOT NULL
DROP VIEW SalesPersonPerform ;
GO
CREATE VIEW SalesPersonPerform
AS
SELECT TOP 100 SalesPersonID, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE OrderDate > '12/31/2000'
GROUP BY SalesPersonID;
GO

