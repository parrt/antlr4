USE AdventureWorks;
GO
SELECT CHARINDEX('bicycle', DocumentSummary)
FROM Production.Document
WHERE DocumentID = 3;
GO
