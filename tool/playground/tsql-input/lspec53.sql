USE AdventureWorks;
GO
SELECT c.FirstName, c.LastName, VacationHours, SickLeaveHours, 
    VacationHours + SickLeaveHours AS 'Total Hours Away'
FROM HumanResources.Employee AS e
    JOIN Person.Contact AS c ON e.ContactID = c.ContactID
ORDER BY 'Total Hours Away' ASC;
GO

