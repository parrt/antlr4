USE AdventureWorks;
GO
IF EXISTS (SELECT name FROM sys.objects
	      WHERE name = 'reminder' AND type = 'TR')
	   DROP TRIGGER Person.reminder;
	GO
	CREATE TRIGGER reminder
	ON Person.Address
	AFTER UPDATE 
	AS 
	IF ( UPDATE (StateProvinceID) OR UPDATE (PostalCode) )
		BEGIN
			RAISERROR (50009, 16, 10)
		END;
		GO
		-- Test the trigger.
UPDATE Person.Address
SET PostalCode = 99999
WHERE PostalCode = '12345';
GO
