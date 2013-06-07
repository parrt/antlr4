USE AdventureWorks;
GO
SET STATISTICS XML ON;
GO
-- First query.
SELECT EmployeeID 
FROM HumanResources.Employee
WHERE NationalIDNumber = '509647174';
GO
-- Second query.
SELECT EmployeeID, Title 
FROM HumanResources.Employee
WHERE Title LIKE 'Production%';
GO
SET STATISTICS XML OFF;
GO

