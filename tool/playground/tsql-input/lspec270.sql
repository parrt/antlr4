--Back up the files in SalesGroup1:
BACKUP DATABASE Sales
   FILEGROUP = 'SalesGroup1',
   FILEGROUP = 'SalesGroup2'
   TO DISK = 'Z:\SQLServerBackups\SalesFiles.bck'
   WITH 
      DIFFERENTIAL
GO
