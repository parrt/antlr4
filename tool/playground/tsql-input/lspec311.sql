USE AdventureWorks;
GO
SELECT p.FirstName, p.LastName, s.SalesYTD, s.SalesPersonID
FROM Person.Contact p JOIN Sales.SalesPerson s ON p.ContactID = s.SalesPersonID
WHERE CAST(CAST(s.SalesYTD AS int) AS char(20)) LIKE '2%';
GO
