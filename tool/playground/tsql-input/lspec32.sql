USE AdventureWorks ;
GO
SELECT ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE UnitPrice < $5.00
ORDER BY ProductID
COMPUTE SUM(LineTotal) BY ProductID ;
GO

