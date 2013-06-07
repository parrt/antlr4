USE AdventureWorks ;
GO
SELECT ProductID, OrderQty, UnitPrice, LineTotal
FROM Sales.SalesOrderDetail
WHERE UnitPrice < $5.00
ORDER BY ProductID, OrderQty, LineTotal
COMPUTE SUM(LineTotal) BY ProductID, OrderQty
COMPUTE SUM(LineTotal) BY ProductID ;
GO

