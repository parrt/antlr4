USE master;
GO
ALTER DATABASE AdventureWorks 
MODIFY FILEGROUP Test1FG1 DEFAULT;
GO
ALTER DATABASE AdventureWorks 
MODIFY FILEGROUP [PRIMARY] DEFAULT;
GO

