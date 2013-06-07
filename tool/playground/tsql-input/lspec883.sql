USE AdventureWorks;
GO
SELECT FirstName, REVERSE(FirstName) AS Reverse
FROM Person.Contact
WHERE ContactID < 5
ORDER BY FirstName;
GO

