EXEC sp_addlinkedserver Server_Remote;
GO
USE tempdb;
GO
CREATE SYNONYM MyEmployee FOR Server_Remote.AdventureWorks.HumanResources.Employee;
GO
