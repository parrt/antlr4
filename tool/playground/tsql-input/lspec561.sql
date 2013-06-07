-- Check the current database.
DBCC CHECKDB;
GO
-- Check the AdventureWorks database without nonclustered indexes.
DBCC CHECKDB ('AdventureWorks', NOINDEX);
GO

DBCC CHECKDB WITH NO_INFOMSGS;
GO


