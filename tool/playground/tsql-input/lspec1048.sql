USE AdventureWorks;
GO
WITH Sales_CTE (SalesPersonID, NumberOfOrders, MaxDate)
AS
(
	    SELECT SalesPersonID, COUNT(*), MAX(OrderDate)
	    FROM Sales.SalesOrderHeader
	    GROUP BY SalesPersonID
)
SELECT E.EmployeeID, OS.NumberOfOrders, OS.MaxDate,
    E.ManagerID, OM.NumberOfOrders, OM.MaxDate
FROM HumanResources.Employee AS E
    JOIN Sales_CTE AS OS
    ON E.EmployeeID = OS.SalesPersonID
    LEFT OUTER JOIN Sales_CTE AS OM
    ON E.ManagerID = OM.SalesPersonID
ORDER BY E.EmployeeID;
GO
