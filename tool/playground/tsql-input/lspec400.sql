USE AdventureWorks;
GO
SELECT Definition 
FROM sys.sql_modules AS m
JOIN sys.objects AS o ON m.object_id = o.object_id 
    AND TYPE IN ('FN', 'IF', 'TF');
GO

