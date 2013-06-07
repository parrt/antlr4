USE AdventureWorks;
GO
SELECT RIGHT(FirstName, 5) AS 'First Name'
FROM Person.Contact
WHERE ContactID < 5
ORDER BY FirstName;
GO

