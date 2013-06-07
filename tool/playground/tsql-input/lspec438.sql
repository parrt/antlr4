USE AdventureWorks;
GO
SELECT definition 
FROM sys.sql_modules 
JOIN sys.objects ON sys.sql_modules.object_id = sys.objects.object_id AND TYPE = 'P';
