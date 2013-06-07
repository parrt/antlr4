USE AdventureWorks;
GO
SELECT FILE_IDEX('AdventureWorks_Data')AS 'File ID';
GO

USE AdventureWorks;
GO
SELECT FILE_IDEX((SELECT name FROM sys.database_files 
		WHERE type = 1))AS 'File ID';
GO

SELECT FILE_IDEX((SELECT name FROM sys.master_files WHERE type = 4))
AS 'File_ID'

