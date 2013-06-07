USE AdventureWorks ;
GO
SELECT ProductID, SUM(LineTotal) AS Total
FROM Sales.SalesOrderDetail
WHERE UnitPrice < $5.00
GROUP BY ProductID, OrderQty
WITH CUBE
ORDER BY ProductID ;
GO

