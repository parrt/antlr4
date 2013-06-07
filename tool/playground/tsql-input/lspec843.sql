USE AdventureWorks;
GO
SELECT PATINDEX('%en_ure%', DocumentSummary)
FROM Production.Document
WHERE DocumentID = 3;
GO


