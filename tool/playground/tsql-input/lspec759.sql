IF IS_SRVROLEMEMBER ('sysadmin') = 1
	   print 'Current user''s login is a member of the sysadmin role'
ELSE IF IS_SRVROLEMEMBER ('sysadmin') = 0
	   print 'Current user''s login is NOT a member of the sysadmin role'
ELSE IF IS_SRVROLEMEMBER ('sysadmin') IS NULL
	   print 'ERROR: The server role specified is not valid.'

