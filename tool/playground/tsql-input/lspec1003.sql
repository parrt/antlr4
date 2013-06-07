INSERT TOP (2) INTO Table2 (ColumnB) 
     SELECT ColumnA FROM Table1 
     ORDER BY ColumnA

INSERT INTO Table2 (ColumnB) 
     SELECT TOP (2) ColumnA FROM Table1 
     ORDER BY ColumnA

USE AdventureWorks ;
GO
DECLARE @p AS int
SET @p='10'
 SELECT TOP(@p)*
FROM HumanResources.Employee;
GO

USE AdventureWorks ;
GO
SELECT TOP(10) PERCENT WITH TIES
c.FirstName, c.LastName, e.Title, e.Gender, r.Rate
FROM Person.Contact c 
INNER JOIN HumanResources.Employee e
ON c.ContactID = e.ContactID
INNER JOIN HumanResources.EmployeePayHistory r
ON r.EmployeeID = e.EmployeeID
ORDER BY Rate DESC;


