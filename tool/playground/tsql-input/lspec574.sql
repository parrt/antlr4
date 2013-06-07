USE AdventureWorks;
GO
DBCC SHOW_STATISTICS ('Person.Address', AK_Address_rowguid);
GO

USE AdventureWorks;
GO
DBCC SHOW_STATISTICS ('Person.Address', AK_Address_rowguid) WITH HISTOGRAM;
GO


