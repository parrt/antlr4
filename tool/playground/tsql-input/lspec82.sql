USE AdventureWorks;
GO
SELECT FirstName, LastName
FROM Person.Contact
WHERE FirstName LIKE 'Al[^a]%'
ORDER BY FirstName;
