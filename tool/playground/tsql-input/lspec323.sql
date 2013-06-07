USE AdventureWorks;
GO
SELECT CHARINDEX('bike', DocumentSummary)
FROM Production.Document
WHERE DocumentID =6;
GO
