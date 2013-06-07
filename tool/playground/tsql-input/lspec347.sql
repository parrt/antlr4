USE AdventureWorks;
GO
SELECT CustomerID, OrderDate, SubTotal, TotalDue
FROM Sales.SalesOrderHeader
WHERE SalesPersonID = 35
ORDER BY OrderDate 
COMPUTE SUM(SubTotal), SUM(TotalDue);
