USE AdventureWorks ;
GO
SELECT ProductID, OrderQty, LineTotal
FROM Sales.SalesOrderDetail
COMPUTE SUM(OrderQty), SUM(LineTotal) ;
GO

