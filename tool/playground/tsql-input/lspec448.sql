USE AdventureWorks;
GO
IF OBJECT_ID ( 'HumanResources.uspEncryptThis', 'P' ) IS NOT NULL 
    DROP PROCEDURE HumanResources.uspEncryptThis;
GO
CREATE PROCEDURE HumanResources.uspEncryptThis
WITH ENCRYPTION
AS
    SELECT EmployeeID, Title, NationalIDNumber, VacationHours, SickLeaveHours 
    FROM HumanResources.Employee;
GO

