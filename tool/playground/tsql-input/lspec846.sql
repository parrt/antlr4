IF PERMISSIONS(OBJECT_ID('AdventureWorks.Person.Address','U'))&8=8 
	   PRINT 'The current user can insert data into Person.Address.'
ELSE
	   PRINT 'ERROR: The current user cannot insert data into Person.Address.';

