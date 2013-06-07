USE AdventureWorks;
GO
SELECT CHARINDEX('bicycle', DocumentSummary, 5)
FROM Production.Document
WHERE DocumentID = 3;
GO
