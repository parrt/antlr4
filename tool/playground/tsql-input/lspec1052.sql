USE AdventureWorks;
GO
--Creates an infinite loop
WITH cte (EmployeeID, ManagerID, Title) as
(
	    SELECT EmployeeID, ManagerID, Title
	    FROM HumanResources.Employee
	    WHERE ManagerID IS NOT NULL
	  UNION ALL
	    SELECT cte.EmployeeID, cte.ManagerID, cte.Title
	    FROM cte 
	    JOIN  HumanResources.Employee AS e 
	        ON cte.ManagerID = e.EmployeeID
	)
	--Uses MAXRECURSION to limit the recursive levels to 2
SELECT EmployeeID, ManagerID, Title
FROM cte
OPTION (MAXRECURSION 2);
GO
