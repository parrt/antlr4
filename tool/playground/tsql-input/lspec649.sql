USE AdventureWorks ;
GO
SELECT DepartmentID, Name 
FROM HumanResources.Department 
WHERE EXISTS (SELECT NULL)
ORDER BY Name ASC ;


USE AdventureWorks ;
GO
SELECT a.FirstName, a.LastName
FROM Person.Contact AS a
WHERE EXISTS
(SELECT * 
	 FROM HumanResources.Employee AS b
	 WHERE a.ContactId = b.ContactID
	 AND a.LastName = 'Johnson');
GO


USE AdventureWorks ;
GO
SELECT a.FirstName, a.LastName
FROM Person.Contact AS a
WHERE a.LastName IN
(SELECT a.LastName
	 FROM HumanResources.Employee AS b
	 WHERE a.ContactId = b.ContactID
	 AND a.LastName = 'Johnson');
GO

