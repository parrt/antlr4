-- Use the specifically named INDEX.
USE AdventureWorks ;
GO
SELECT c.FirstName, c.LastName, e.Title
FROM HumanResources.Employee e WITH (INDEX(IX_Employee_ManagerID))
JOIN Person.Contact c on e.ContactID = c.ContactID
WHERE ManagerID = 3 ;
GO

-- Force a table scan by using INDEX = 0.
USE AdventureWorks ;
GO
SELECT c.LastName, c.FirstName, e.Title
FROM HumanResources.Employee e WITH (INDEX = 0) JOIN Person.Contact c
ON e.ContactID = c.ContactID
WHERE LastName = 'Johnson' ;
GO

