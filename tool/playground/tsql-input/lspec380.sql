USE master;
GO
IF DB_ID (N'Archive') IS NOT NULL
DROP DATABASE Archive;
GO
-- Get the SQL Server data path
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
                  FROM master.sys.master_files
                  WHERE database_id = 1 AND file_id = 1);

-- execute the CREATE DATABASE statement 
EXECUTE ('CREATE DATABASE Archive 
ON
PRIMARY  
    (NAME = Arch1,
    FILENAME = '''+ @data_path + 'archdat1.mdf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    ( NAME = Arch2,
    FILENAME = '''+ @data_path + 'archdat2.ndf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    ( NAME = Arch3,
    FILENAME = '''+ @data_path + 'archdat3.ndf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20)
LOG ON 
   (NAME = Archlog1,
    FILENAME = '''+ @data_path + 'archlog1.ldf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
   (NAME = Archlog2,
    FILENAME = '''+ @data_path + 'archlog2.ldf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20)'
);
GO

