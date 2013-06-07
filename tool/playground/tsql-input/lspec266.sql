BACKUP DATABASE AdventureWorks
TO DISK='X:\SQLServerBackups\AdventureWorks1a.bak', 
DISK='Y:\SQLServerBackups\AdventureWorks2a.bak', 
DISK='Z:\SQLServerBackups\AdventureWorks3a.bak'
MIRROR TO DISK='X:\SQLServerBackups\AdventureWorks1b.bak', 
DISK='Y:\SQLServerBackups\AdventureWorks2b.bak', 
DISK='Z:\SQLServerBackups\AdventureWorks3b.bak';
GO
