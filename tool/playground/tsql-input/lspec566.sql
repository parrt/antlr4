USE AdventureWorks; 
GO
DBCC DBREINDEX ('HumanResources.Employee', PK_Employee_EmployeeID,80);
GO

USE AdventureWorks; 
GO
DBCC DBREINDEX ('HumanResources.Employee', '', 70);
GO


