USE AdventureWorks;
GO
SELECT FirstName, LastName, e.Title
FROM HumanResources.Employee AS e
    JOIN Person.Contact AS c 
    ON e.ContactID = c.ContactID
WHERE e.Title IN ('Design Engineer', 'Tool Designer', 'Marketing Assistant');
GO


