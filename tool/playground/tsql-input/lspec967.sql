USE AdventureWorks;
GO
SELECT RTRIM(LastName) + ',' + SPACE(2) +  LTRIM(FirstName)
FROM Person.Contact
ORDER BY LastName, FirstName;
GO

