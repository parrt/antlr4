RESTORE DATABASE AdventureWorks
   FROM AdventureWorksBackups
   WITH NORECOVERY, 
      MOVE 'AdventureWorks_Data' TO 
'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\NewAdvWorks.mdf', 
      MOVE 'AdventureWorks_Log' 
TO 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\NewAdvWorks.ldf'
RESTORE LOG AdventureWorks
   FROM AdventureWorksBackups
   WITH RECOVERY

