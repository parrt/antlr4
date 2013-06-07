SELECT QUOTENAME(DB_NAME(database_id)) 
    + N'.' 
    + QUOTENAME(OBJECT_SCHEMA_NAME(object_id, database_id)) 
    + N'.' 
    + QUOTENAME(OBJECT_NAME(object_id, database_id))
    , * 
FROM sys.dm_db_index_operational_stats(null, null, null, null);
GO

