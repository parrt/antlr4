USE AdventureWorks;
GO
SET SHOWPLAN_ALL ON;
GO
-- First query.
SELECT EmployeeID 
FROM HumanResources.Employee
WHERE NationalIDNumber = '509647174';
GO
-- Second query.
SELECT EmployeeID, EmergencyContactID 
FROM HumanResources.Employee
WHERE EmergencyContactID LIKE '1%';
GO
SET SHOWPLAN_ALL OFF;
GO

