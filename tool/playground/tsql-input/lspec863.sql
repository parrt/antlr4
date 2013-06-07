USE AdventureWorks
GO
SELECT [Name]
, REPLICATE('0', 4) + [ProductLine] AS 'Line Code'
FROM [Production].[Product]
WHERE [ProductLine] = 'T'
ORDER BY [Name]
GO

