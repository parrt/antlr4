USE AdventureWorks ;
GO
SELECT ProductID, AVG(UnitPrice) AS 'Average Price'
FROM Sales.SalesOrderDetail
WHERE OrderQty > 10
GROUP BY ProductID
ORDER BY ProductID ;
GO

USE AdventureWorks ;
GO
SELECT ProductID, AVG(UnitPrice) AS 'Average Price'
FROM Sales.SalesOrderDetail
WHERE OrderQty > 10
GROUP BY ALL ProductID
ORDER BY ProductID ;
GO

