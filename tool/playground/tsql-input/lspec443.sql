USE AdventureWorks;
GO
IF OBJECT_ID ( 'HumanResources.uspGetEmployees2', 'P' ) IS NOT NULL 
    DROP PROCEDURE HumanResources.uspGetEmployees2;
GO
CREATE PROCEDURE HumanResources.uspGetEmployees2 
    @LastName nvarchar(50) = N'D%', 
    @FirstName nvarchar(50) = N'%'
AS 
    SELECT FirstName, LastName, JobTitle, Department
    FROM HumanResources.vEmployeeDepartment
    WHERE FirstName LIKE @FirstName 
        AND LastName LIKE @LastName;
GO

