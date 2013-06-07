USE AdventureWorks;
GO
SELECT (LastName + ', ' + FirstName) AS Name
FROM Person.Contact
ORDER BY LastName ASC, FirstName ASC;
