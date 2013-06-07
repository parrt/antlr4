USE AdventureWorks ;
GO
IF OBJECT_ID ('hiredate_view', 'view') IS NOT NULL
DROP VIEW hiredate_view ;
GO
CREATE VIEW hiredate_view
AS 
SELECT c.FirstName, c.LastName, e.EmployeeID, e.HireDate
FROM HumanResources.Employee e JOIN Person.Contact c on e.ContactID = c.ContactID ;
GO

