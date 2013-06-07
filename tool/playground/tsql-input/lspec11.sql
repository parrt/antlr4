USE AdventureWorks ;
GO
SELECT DISTINCT c.LastName, c.FirstName 
FROM Person.Contact c JOIN HumanResources.Employee e
ON e.ContactID = c.ContactID WHERE 5000.00 IN
(SELECT Bonus
FROM Sales.SalesPerson sp
WHERE e.EmployeeID = sp.SalesPersonID) ;
GO

