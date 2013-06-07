RESTORE DATABASE AdventureWorks
   FROM AdventureWorksBackups
   WITH NORECOVERY;

RESTORE LOG AdventureWorks
   FROM AdventureWorksBackups
   WITH RECOVERY, STOPAT = 'Apr 15, 2020 12:00 AM';

RESTORE LOG AdventureWorks
   FROM AdventureWorksBackups
   WITH RECOVERY, STOPAT = 'Apr 15, 2020 12:00 AM';

