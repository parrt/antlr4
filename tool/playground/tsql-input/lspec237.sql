USE AdventureWorks ;
GO
CREATE VIEW EmployeeeHireDate
AS
SELECT c.FirstName, c.LastName, e.HireDate
FROM HumanResources.Employee e JOIN Person.Contact c
ON e.ContactID = c.ContactID ;
GO

