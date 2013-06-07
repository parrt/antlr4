USE AdventureWorks;
GO
SELECT SalesPersonID, CustomerID, OrderDate, SubTotal, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY SalesPersonID, OrderDate 
COMPUTE SUM(SubTotal), SUM(TotalDue) BY SalesPersonID;
