USE AdventureWorks
GO
BEGIN TRANSACTION ListPriceUpdate
	   WITH MARK 'UPDATE Product list prices';
	GO

	UPDATE Production.Product
	   SET ListPrice = ListPrice * 1.10
	   WHERE ProductNumber LIKE 'BK-%';
	GO

	COMMIT TRANSACTION ListPriceUpdate;
	GO

	-- Time passes. Regular database 
-- and log backups are taken.
-- An error occurs in the database.
USE master
GO

RESTORE DATABASE AdventureWorks
FROM AdventureWorksBackups
WITH FILE = 3, NORECOVERY;
GO

RESTORE LOG AdventureWorks
   FROM AdventureWorksBackups 
   WITH FILE = 4,
   RECOVERY, 
   STOPATMARK = 'ListPriceUpdate';

