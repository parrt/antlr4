IF PERMISSIONS(OBJECT_ID('AdventureWorks.Person.Address','U'))&0x80000=0x80000
	   PRINT 'INSERT on Person.Address is grantable.'
ELSE
	   PRINT 'You may not GRANT INSERT permissions on Person.Address.';

