USE AdventureWorks;
GO
SET NOCOUNT OFF;
GO
-- Display the count message.
SELECT TOP(5)LastName
FROM Person.Contact
WHERE LastName LIKE 'A%';
GO
-- SET NOCOUNT to ON to no longer display the count message.
SET NOCOUNT ON;
GO
SELECT TOP(5) LastName
FROM Person.Contact
WHERE LastName LIKE 'A%';
GO
-- Reset SET NOCOUNT to OFF
SET NOCOUNT OFF;
GO

