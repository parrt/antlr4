E AdventureWorks ;
GO
SELECT *
FROM Sales.Customer TABLESAMPLE SYSTEM (10 PERCENT) ;
