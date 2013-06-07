USE AdventureWorks;
GO
SELECT (LastName + ',' + SPACE(1) + SUBSTRING(FirstName, 1, 1) + '.') AS Name, e.Title
FROM Person.Contact AS c
    JOIN HumanResources.Employee AS e
    ON c.ContactID = e.ContactID
WHERE e.Title LIKE 'Vice%'
ORDER BY LastName ASC;
GO
