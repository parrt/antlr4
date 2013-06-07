USE AdventureWorks;
GO
-- Replacing NULL value with temporary data.
UPDATE Production.Document
SET DocumentSummary = N'Replacing NULL value'
WHERE DocumentID = 1;
GO
SELECT DocumentSummary 
FROM Production.Document
WHERE DocumentID = 1;
GO
-- Replacing temporary data with the correct data. Setting @Length to NULL 
-- truncates all existing data from the @Offset position.
UPDATE Production.Document
SET DocumentSummary .WRITE(N'Carefully inspect and maintain the tires and crank arms.',0,NULL)
WHERE DocumentID = 1;
GO
SELECT DocumentSummary 
FROM Production.Document
WHERE DocumentID = 1;
GO
-- Appending additional data to the end of the column by setting 
-- @Offset to NULL.
UPDATE Production.Document
SET DocumentSummary .WRITE (N' Appending data to the end of the column.', NULL, 0)
WHERE DocumentID = 1;
GO
SELECT DocumentSummary 
FROM Production.Document
WHERE DocumentID = 1;
GO
-- Removing all data from @Offset to the end of the existing value by 
-- setting expression to NULL. 
UPDATE Production.Document
SET DocumentSummary .WRITE (NULL, 56, 0)
WHERE DocumentID = 1;
GO
SELECT DocumentSummary 
FROM Production.Document
WHERE DocumentID = 1;
GO
-- Removing partial data beginning at position 9 and ending at 
-- position 21.
UPDATE Production.Document
SET DocumentSummary .WRITE ('',9, 12)
WHERE DocumentID = 1;
GO
SELECT DocumentSummary 
FROM Production.Document
WHERE DocumentID = 1;
GO
