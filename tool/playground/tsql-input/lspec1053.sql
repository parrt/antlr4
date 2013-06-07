USE AdventureWorks;
GO
WITH cte (EmployeeID, ManagerID, Title)
AS
(
	    SELECT EmployeeID, ManagerID, Title
	    FROM HumanResources.Employee
	    WHERE ManagerID IS NOT NULL
	  UNION ALL
	    SELECT  e.EmployeeID, e.ManagerID, e.Title
	    FROM HumanResources.Employee AS e
	    JOIN cte ON e.ManagerID = cte.EmployeeID
)
SELECT EmployeeID, ManagerID, Title
FROM cte;
GO
