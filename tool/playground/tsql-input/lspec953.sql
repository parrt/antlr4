USE AdventureWorks;
GO
SET SHOWPLAN_XML ON;
GO
-- First query.
SELECT EmployeeID 
FROM HumanResources.Employee
WHERE NationalIDNumber = '509647174';
GO
-- Second query.
SELECT EmployeeID, ContactID 
FROM HumanResources.Employee
WHERE Title LIKE 'Production%';
GO
SET SHOWPLAN_XML OFF;

