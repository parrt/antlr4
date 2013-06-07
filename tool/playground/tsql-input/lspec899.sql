USE AdventureWorks;
GO
WITH OrderedOrders AS
(
	    SELECT SalesOrderID, OrderDate,
	    ROW_NUMBER() OVER (ORDER BY OrderDate) AS 'RowNumber'
	    FROM Sales.SalesOrderHeader 
) 
SELECT * 
FROM OrderedOrders 
WHERE RowNumber BETWEEN 50 AND 60;

