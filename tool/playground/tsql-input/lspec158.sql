USE master;
GO
ALTER DATABASE AdventureWorks 
MODIFY FILE
    (NAME = test1dat3,
    SIZE = 20MB);
GO

