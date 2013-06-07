USE AdventureWorks;
GO
IF EXISTS (SELECT name FROM sys.objects
	         WHERE name = 'datedflt' 
		            AND type = 'D')
			   DROP DEFAULT datedflt
GO

USE AdventureWorks;
GO
IF EXISTS (SELECT name FROM sys.objects
	         WHERE name = 'phonedflt' 
		            AND type = 'D')
			   BEGIN 
				      EXEC sp_unbindefault 'Person.Contact.Phone'
				      DROP DEFAULT phonedflt
				   END
				GO


