USE AdventureWorks;
GO
SELECT TOP(100)ProductID, UnitPrice, OrderQty,
   CAST((UnitPrice) AS int) % OrderQty AS Modulo
FROM Sales.SalesOrderDetail;
GO
