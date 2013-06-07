-- Test membership in db_owner and print appropriate message.
IF IS_MEMBER ('db_owner') = 1
	   print 'Current user is a member of the db_owner role'
ELSE IF IS_MEMBER ('db_owner') = 0
	   print 'Current user is NOT a member of the db_owner role'
ELSE IF IS_MEMBER ('db_owner') IS NULL
	   print 'ERROR: Invalid group / role specified'
	go

	-- Execute SELECT if user is a member of ADVWORKS\Shipping.
IF IS_MEMBER ('ADVWORKS\Shipping') = 1
	   SELECT 'User ' + USER + ' is a member of ADVWORKS\Shipping.' 
	go

