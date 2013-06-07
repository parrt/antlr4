USE UserDB;
GO
DBCC SHRINKFILE (DataFile1, 7);
GO

USE AdventureWorks;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE AdventureWorks
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (AdventureWorks_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE AdventureWorks
SET RECOVERY FULL;
GO

USE AdventureWorks;
GO
SELECT file_id, name
FROM sys.database_files;
GO
DBCC SHRINKFILE (1, TRUNCATEONLY);

USE AdventureWorks;
GO
-- Create a data file and assume it contains data.
ALTER DATABASE AdventureWorks 
ADD FILE (
	    NAME = Test1data,
	    FILENAME = 'C:\t1data.ndf',
	    SIZE = 5MB
	    );
	GO
	-- Empty the data file.
DBCC SHRINKFILE ('Test1data', EMPTYFILE);
GO
-- Remove the data file from the database.
ALTER DATABASE AdventureWorks
REMOVE FILE Test1data;
GO


