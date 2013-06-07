USE AdventureWorks;
GO
SELECT SalesPersonID, FirstName, LastName, SalesQuota, SalesQuota/12 AS 'Sales Target Per Month'
FROM Sales.SalesPerson s 
    JOIN HumanResources.Employee e ON s.SalesPersonID = e.EmployeeID
    JOIN Person.Contact c ON e.ContactID = c.ContactID;
