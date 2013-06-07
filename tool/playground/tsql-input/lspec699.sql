USE AdventureWorks;
GO
DECLARE @NmbrContacts int
SELECT @NmbrContacts = COUNT(*)
FROM Person.Contact
PRINT 'The number of contacts as of ' +
      CAST(GETDATE() AS char(20)) + ' is ' +
      CAST(@NmbrContacts AS char (10))
GO

