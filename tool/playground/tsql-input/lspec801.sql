USE AdventureWorks;
GO
DECLARE @MyID int;
SET @MyID = (SELECT OBJECT_ID('AdventureWorks.Production.Product',
		    'U'));
SELECT name, object_id, type_desc
FROM sys.objects
WHERE name = OBJECT_NAME(@MyID);
GO


