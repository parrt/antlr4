USE master
GO
ALTER DATABASE AdventureWorks
ADD FILEGROUP Test1FG1;
GO
-- Get the SQL Server data path
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
                  FROM master.sys.master_files
                  WHERE database_id = 1 AND file_id = 1);
EXECUTE (
'ALTER DATABASE AdventureWorks 
ADD FILE 
(
    NAME = test1dat3,
    FILENAME = '''+ @data_path + 't1dat3.ndf'',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
),
(
    NAME = test1dat4,
    FILENAME = '''+ @data_path + 't1dat4.ndf'',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP Test1FG1'
);
GO

