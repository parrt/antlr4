USE AdventureWorks ;
GO
SELECT ProductName, CustomerName, SUM(Orders) AS 'Sum orders'
FROM dbo.CubeExample
GROUP BY ProductName, CustomerName
WITH ROLLUP ;
GO

