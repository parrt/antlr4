DBCC UPDATEUSAGE (0);
GO

USE AdventureWorks;
GO
DBCC UPDATEUSAGE ('AdventureWorks') WITH NO_INFOMSGS; 
GO

USE AdventureWorks;
GO
DBCC UPDATEUSAGE ('AdventureWorks','HumanResources.Employee');
GO

USE AdventureWorks;
GO
DBCC UPDATEUSAGE ('AdventureWorks', 'HumanResources.Employee', 'IX_Employee_ManagerID');
GO


