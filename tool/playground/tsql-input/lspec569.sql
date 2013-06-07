DECLARE @dbcc_stmt sysname;
SET @dbcc_stmt = 'CHECKDB';
DBCC HELP (@dbcc_stmt);
GO

DBCC HELP ('?');
GO


