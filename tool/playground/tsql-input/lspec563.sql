USE AdventureWorks;
GO
DBCC CHECKIDENT ('HumanResources.Employee');
GO

USE AdventureWorks;
GO
DBCC CHECKIDENT ('HumanResources.Employee', NORESEED);
GO

USE AdventureWorks;
GO
DBCC CHECKIDENT ('HumanResources.Employee', RESEED, 30);
GO


