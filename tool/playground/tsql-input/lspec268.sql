-- To permit log backups, before the full database backup, modify the database 
-- to use the full recovery model.
USE master;
GO
ALTER DATABASE AdventureWorks
   SET RECOVERY FULL;
GO
-- Create AdvWorksData and AdvWorksLog logical backup devices. 
USE master
GO
EXEC sp_addumpdevice 'disk', 'AdvWorksData', 
'Z:\SQLServerBackups\AdvWorksData.bak';
GO
EXEC sp_addumpdevice 'disk', 'AdvWorksLog', 
'Z:\SQLServerBackups\AdvWorksLog.bak';
GO

-- Back up the full AdventureWorks database.
BACKUP DATABASE AdventureWorks TO AdvWorksData;
GO
-- Back up the AdventureWorks log.
BACKUP LOG AdventureWorks
   TO AdvWorksLog;
GO
