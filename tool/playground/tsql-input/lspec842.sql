USE AdventureWorks;
GO
SELECT PATINDEX('%ensure%',DocumentSummary)
FROM Production.Document
WHERE DocumentID = 3;
GO

