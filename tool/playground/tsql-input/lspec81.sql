USE AdventureWorks;
GO 
SELECT e.EmployeeID, c.FirstName, c.LastName, a.PostalCode
FROM HumanResources.Employee AS e
    INNER JOIN Person.Contact AS c ON e.ContactID = c.ContactID
INNER JOIN HumanResources.EmployeeAddress AS ea ON e.EmployeeID = ea.EmployeeID
    INNER JOIN Person.Address AS a ON a.AddressID = ea.AddressID
WHERE a.PostalCode LIKE '[0-9][0-9][0-9][0-9]';
GO
