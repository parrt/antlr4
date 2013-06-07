USE master;
GO
IF DB_ID (N'FileStreamDB') IS NOT NULL
DROP DATABASE FileStreamDB;
GO
-- Get the SQL Server data path.
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
FROM master.sys.master_files
WHERE database_id = 1 AND file_id = 1);

-- Execute the CREATE DATABASE statement.
EXECUTE ('CREATE DATABASE FileStreamDB
ON PRIMARY 
(
NAME = FileStreamDB_data 
,FILENAME = ''' + @data_path + 'FileStreamDB_data.mdf''
,SIZE = 10MB
,MAXSIZE = 50MB
,FILEGROWTH = 15%
),
FILEGROUP FileStreamPhotos CONTAINS FILESTREAM DEFAULT
(
NAME = FSPhotos
,FILENAME = ''C:\MyFSfolder\Photos''
-- SIZE, MAXSIZE, FILEGROWTH should not be specified here.
-- If they are specified an error will be raised.
),
FILEGROUP FileStreamResumes CONTAINS FILESTREAM
(
NAME = FileStreamResumes
,FILENAME = ''C:\MyFSfolder\Resumes''
) 
LOG ON
(
NAME = FileStream_log
,FILENAME = ''' + @data_path + 'FileStreamDB_log.ldf''
,SIZE = 5MB
,MAXSIZE = 25MB
,FILEGROWTH = 5MB
)'
);
GO

