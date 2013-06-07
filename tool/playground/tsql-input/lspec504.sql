USE AdventureWorks
IF EXISTS (SELECT * FROM sys.triggers
    WHERE parent_class = 0 AND name = 'safety')
DROP TRIGGER safety
ON DATABASE
GO
CREATE TRIGGER safety 
ON DATABASE 
FOR DROP_SYNONYM
AS 
   RAISERROR ('You must disable Trigger "safety" to drop synonyms!',10, 1)
   ROLLBACK
GO
DROP TRIGGER safety
ON DATABASE
GO

