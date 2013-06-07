USE AdventureWorks;
GO
CREATE PROCEDURE HumanResources.uspEmployeesInDepartment 
@DeptValue int
WITH EXECUTE AS OWNER
AS
SELECT e.EmployeeID, c.LastName, c.FirstName, e.Title
FROM Person.Contact AS c 
INNER JOIN HumanResources.Employee AS e
    ON c.ContactID = e.ContactID
INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON e.EmployeeID = edh.EmployeeID
WHERE edh.DepartmentID = @DeptValue
ORDER BY c.LastName, c.FirstName;
GO

-- Execute the stored procedure by specifying department 5.
EXECUTE HumanResources.uspEmployeesInDepartment 5;
GO


