USE master;
GO
sp_detach_db Archive;
GO
-- Get the SQL Server data path
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
                  FROM master.sys.master_files
                  WHERE database_id = 1 AND file_id = 1);
-- Execute CREATE DATABASE FOR ATTACH statement
EXEC ('CREATE DATABASE Archive
      ON (FILENAME = '''+ @data_path + 'archdat1.mdf'')
      FOR ATTACH');
GO

