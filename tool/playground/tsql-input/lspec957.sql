USE AdventureWorks;
GO
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
GO
BEGIN TRANSACTION;
	GO
	SELECT * 
	    FROM HumanResources.EmployeePayHistory;
	GO
	SELECT * 
	    FROM HumanResources.Department;
	GO
	COMMIT TRANSACTION;
	GO

