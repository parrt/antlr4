USE AdventureWorks ;
GO

SELECT c.LastName, c.FirstName, e.Title 
INTO EmployeeOne
FROM Person.Contact c JOIN HumanResources.Employee e
ON e.ContactID = c.ContactID
WHERE ManagerID = 66 ;
GO
SELECT c.LastName, c.FirstName, e.Title 
INTO EmployeeTwo
FROM Person.Contact c JOIN HumanResources.Employee e
ON e.ContactID = c.ContactID
WHERE ManagerID = 66 ;
GO
SELECT c.LastName, c.FirstName, e.Title 
INTO EmployeeThree
FROM Person.Contact c JOIN HumanResources.Employee e
ON e.ContactID = c.ContactID
WHERE ManagerID = 66 ;
GO
-- Union ALL
SELECT LastName, FirstName
FROM EmployeeOne
UNION ALL
SELECT LastName, FirstName 
FROM EmployeeTwo
UNION ALL
SELECT LastName, FirstName 
FROM EmployeeThree ;
GO

SELECT LastName, FirstName
FROM EmployeeOne
UNION 
SELECT LastName, FirstName 
FROM EmployeeTwo
UNION 
SELECT LastName, FirstName 
FROM EmployeeThree ;
GO

SELECT LastName, FirstName 
FROM EmployeeOne
UNION ALL
(
SELECT LastName, FirstName 
FROM EmployeeTwo
UNION
SELECT LastName, FirstName 
FROM EmployeeThree
) ;
GO

