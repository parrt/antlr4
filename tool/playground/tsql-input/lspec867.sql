-- This database RESTORE halted prematurely due to power failure.
RESTORE DATABASE AdventureWorks
   FROM AdventureWorksBackups
-- Here is the RESTORE RESTART operation.
RESTORE DATABASE AdventureWorks 
   FROM AdventureWorksBackups WITH RESTART

