USE AdventureWorks;
GO
SELECT DISTINCT OBJECT_SCHEMA_NAME(object_id)
FROM master.sys.objects;
GO
USE AdventureWorks;
GO
SELECT DISTINCT OBJECT_SCHEMA_NAME(object_id, 1) AS schema_name
FROM master.sys.objects;
GO

