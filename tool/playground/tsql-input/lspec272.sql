BACKUP DATABASE AdventureWorks
TO TAPE = '\\.\tape0', TAPE = '\\.\tape1'
MIRROR TO TAPE = '\\.\tape2', TAPE = '\\.\tape3'
WITH
   FORMAT,
   MEDIANAME = 'AdventureWorksSet1'
