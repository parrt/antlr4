USE AdventureWorks;
GO
SELECT name, object_id, schema_id, type_desc
FROM sys.objects 
WHERE OBJECTPROPERTYEX(object_id, N'TableHasForeignKey') = 1
ORDER BY name;
GO


