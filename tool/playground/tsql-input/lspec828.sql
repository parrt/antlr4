USE AdventureWorks
GO
CREATE TABLE myTable(FileName nvarchar(60), 
	  FileType nvarchar(60), Document varbinary(max))
GO

INSERT INTO myTable(FileName, FileType, Document) 
   SELECT 'Text1.txt' AS FileName, 
      '.txt' AS FileType, 
      * FROM OPENROWSET(BULK N'C:\Text1.txt', SINGLE_BLOB) AS Document
GO

