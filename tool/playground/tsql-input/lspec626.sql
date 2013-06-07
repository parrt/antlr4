USE AdventureWorks;
GO
DISABLE TRIGGER Person.uAddress ON Person.Address;
GO
ENABLE Trigger Person.uAddress ON Person.Address;
GO

IF EXISTS (SELECT * FROM sys.triggers
	    WHERE parent_class = 0 AND name = 'safety')
	DROP TRIGGER safety ON DATABASE;
GO
CREATE TRIGGER safety 
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE 
AS 
   PRINT 'You must disable Trigger "safety" to drop or alter tables!' 
   ROLLBACK;
GO
DISABLE TRIGGER safety ON DATABASE;
GO
ENABLE TRIGGER safety ON DATABASE;
GO


USE AdventureWorks;
GO
ENABLE Trigger ALL ON ALL SERVER;
GO


