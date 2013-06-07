RESTORE DATABASE AdventureWorks
   FROM DISK = 'Z:\SQLServerBackups\AdventureWorks.bak'
   WITH FILE = 6
      NORECOVERY;
RESTORE DATABASE AdventureWorks
   FROM DISK = 'Z:\SQLServerBackups\AdventureWorks.bak'
   WITH FILE = 9
      RECOVERY;

