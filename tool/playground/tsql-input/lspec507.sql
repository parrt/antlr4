SELECT TE.*
FROM sys.trigger_events AS TE
JOIN sys.triggers AS T
ON T.object_id = TE.object_id
WHERE T.parent_class = 0
AND T.name = 'safety'
GO

