USE AdventureWorks;
GO
SELECT City, PostalCode
FROM Person.Address 
WHERE ISNUMERIC(PostalCode)<> 1;
GO

