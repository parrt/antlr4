USE AdventureWorks;
GO
SELECT UPPER(RTRIM(LastName)) + ', ' + FirstName AS Name
FROM Person.Contact
ORDER BY LastName;
GO
