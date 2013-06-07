BACKUP DATABASE AdventureWorks
TO TAPE = '\\.\tape0'
MIRROR TO TAPE = '\\.\tape1'
MIRROR TO TAPE = '\\.\tape2'
MIRROR TO TAPE = '\\.\tape3'
WITH
   FORMAT,
   MEDIANAME = 'AdventureWorksSet0'
