USE AdventureWorks;
GO
SELECT FirstName, LastName
FROM Person.Contact
WHERE FirstName LIKE '_an'
ORDER BY FirstName;
