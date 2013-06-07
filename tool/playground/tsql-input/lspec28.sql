USE AdventureWorks ;
GO
SELECT ProductID, OrderQty, UnitPrice, LineTotal
FROM Sales.SalesOrderDetail
WHERE UnitPrice < $2.00
COMPUTE SUM(OrderQty), SUM(LineTotal) ;
GO

