USE AdventureWorks;
GO
IF OBJECT_ID ( 'HumanResources.uspGetEmployees', 'P' ) IS NOT NULL 
    DROP PROCEDURE HumanResources.uspGetEmployees;
GO
CREATE PROCEDURE HumanResources.uspGetEmployees 
    @LastName nvarchar(50), 
    @FirstName nvarchar(50) 
AS 
    SELECT FirstName, LastName, JobTitle, Department
    FROM HumanResources.vEmployeeDepartment
    WHERE FirstName = @FirstName AND LastName = @LastName;
GO

