USE AdventureWorks;
GO
DECLARE @CurrentApp varchar(40)
SET @CurrentApp = APP_NAME()
IF @CurrentApp <> 'SQL Server Management Studio - Query'
PRINT 'This process was not started by a SQL Server Management Studio query session.';
GO
