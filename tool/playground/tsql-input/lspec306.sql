USE AdventureWorks;
GO
SELECT c.FirstName, c.LastName, SUBSTRING(c.Title, 1, 25) AS Title, CAST(e.SickLeaveHours AS char(1)) AS 'Sick Leave'
FROM HumanResources.Employee e JOIN Person.Contact c ON e.EmployeeID = c. ContactID
WHERE NOT EmployeeID >5
