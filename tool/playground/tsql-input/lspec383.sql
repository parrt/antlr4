USE master;
GO
-- Get the SQL Server data path
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
                  FROM master.sys.master_files
                  WHERE database_id = 1 AND file_id = 1);
-- execute the CREATE DATABASE statement 
EXECUTE (
'CREATE DATABASE sales_snapshot0600 ON
    ( NAME = SPri1_dat, FILENAME = '''+ @data_path + 'SPri1dat_0600.ss''),
    ( NAME = SPri2_dat, FILENAME = '''+ @data_path + 'SPri2dt_0600.ss''),
    ( NAME = SGrp1Fi1_dat, FILENAME = '''+ @data_path + 'SG1Fi1dt_0600.ss''),
    ( NAME = SGrp1Fi2_dat, FILENAME = '''+ @data_path + 'SG1Fi2dt_0600.ss''),
    ( NAME = SGrp2Fi1_dat, FILENAME = '''+ @data_path + 'SG2Fi1dt_0600.ss''),
    ( NAME = SGrp2Fi2_dat, FILENAME = '''+ @data_path + 'SG2Fi2dt_0600.ss'')
AS SNAPSHOT OF Sales');
GO

