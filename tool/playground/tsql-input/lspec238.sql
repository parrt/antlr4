ALTER VIEW EmployeeeHireDate
AS
SELECT c.FirstName, c.LastName, e.HireDate
FROM HumanResources.Employee e JOIN Person.Contact c
ON E.ContactID = C.ContactID
WHERE HireDate < '1/1/1997' ;
GO

