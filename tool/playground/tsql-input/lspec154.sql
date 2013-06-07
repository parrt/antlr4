USE master;
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
    NAME = Test1dat2,
    FILENAME = '''+ @data_path + 't1dat2.ndf'',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)'
);
GO

