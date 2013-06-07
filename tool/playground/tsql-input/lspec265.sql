BACKUP DATABASE AdventureWorks
TO DISK='X:\SQLServerBackups\AdventureWorks1.bak', 
DISK='Y:\SQLServerBackups\AdventureWorks2.bak', 
DISK='Z:\SQLServerBackups\AdventureWorks3.bak'
WITH FORMAT,
   MEDIANAME = 'AdventureWorksStripedSet0',
   MEDIADESCRIPTION = 'Striped media set for AdventureWorks database;
GO
