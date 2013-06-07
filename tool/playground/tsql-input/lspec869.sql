BACKUP DATABASE AdventureWorks 
   TO AdventureWorksBackups ;

RESTORE FILELISTONLY 
   FROM AdventureWorksBackups ;

RESTORE DATABASE TestDB 
   FROM AdventureWorksBackups 
   WITH MOVE 'AdventureWorks_Data' TO 'C:\MySQLServer\testdb.mdf',
   MOVE 'AdventureWorks_Log' TO 'C:\MySQLServer\testdb.ldf';
GO

