USE AdventureWorks;
GO
SELECT name AS index_name, 
    STATS_DATE(object_id, index_id) AS statistics_update_date
FROM sys.indexes 
WHERE object_id = OBJECT_ID('Person.Address');
GO

