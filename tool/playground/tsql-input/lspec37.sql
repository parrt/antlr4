USE AdventureWorks ;
GO
SELECT ProductName, CustomerName, SUM(Orders)
FROM CubeExample
GROUP BY ProductName, CustomerName
ORDER BY ProductName ;
GO

