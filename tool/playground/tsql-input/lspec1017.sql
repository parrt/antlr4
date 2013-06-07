USE AdventureWorks;
GO
WITH DirectReports(EmployeeID, NewVacationHours, EmployeeLevel)
AS
(SELECT e.EmployeeID, e.VacationHours, 1
	  FROM HumanResources.Employee AS e
	  WHERE e.ManagerID = 12
	  UNION ALL
	  SELECT e.EmployeeID, e.VacationHours, EmployeeLevel + 1
	  FROM HumanResources.Employee as e
	  JOIN DirectReports AS d ON e.ManagerID = d.EmployeeID
)
UPDATE HumanResources.Employee
SET VacationHours = VacationHours * 1.25
FROM HumanResources.Employee AS e
JOIN DirectReports AS d ON e.EmployeeID = d.EmployeeID;
GO
