E AdventureWorks;
GO
WITH DirectReports(ManagerID, EmployeeID, EmployeeLevel) AS 
(
	    SELECT ManagerID, EmployeeID, 0 AS EmployeeLevel
	    FROM HumanResources.Employee
	    WHERE ManagerID IS NULL
	    UNION ALL
	    SELECT e.ManagerID, e.EmployeeID, EmployeeLevel + 1
	    FROM HumanResources.Employee e
	        INNER JOIN DirectReports d
		        ON e.ManagerID = d.EmployeeID 
		)
		SELECT ManagerID, EmployeeID, EmployeeLevel 
		FROM DirectReports ;
		GO
