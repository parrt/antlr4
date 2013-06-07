USE AdventureWorks;
GO
DECLARE @MyTableVar table (
	    DocumentID int NOT NULL,
	    SummaryBefore nvarchar(max),
	    SummaryAfter nvarchar(max));
UPDATE Production.Document
SET DocumentSummary .WRITE (N'features',28,10)
OUTPUT INSERTED.DocumentID,
       DELETED.DocumentSummary, 
       INSERTED.DocumentSummary 
    INTO @MyTableVar
WHERE DocumentID = 3 ;
SELECT DocumentID, SummaryBefore, SummaryAfter 
FROM @MyTableVar;
GO
