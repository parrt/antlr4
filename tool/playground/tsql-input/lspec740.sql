USE AdventureWorks;
GO
SELECT FirstName, LastName, e.Title
FROM HumanResources.Employee AS e
    JOIN Person.Contact AS c 
    ON e.ContactID = c.ContactID
WHERE e.Title = 'Design Engineer' 
   OR e.Title = 'Tool Designer' 
   OR e.Title = 'Marketing Assistant';
GO


