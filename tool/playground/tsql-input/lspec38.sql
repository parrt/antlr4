USE AdventureWorks ;
GO
SELECT ProductName, CustomerName, SUM(Orders)
FROM CubeExample
GROUP BY ProductName, CustomerName
WITH CUBE ;
GO

