IF PERMISSIONS()&2=2
   CREATE TABLE test_table (col1 INT)
ELSE
	   PRINT 'ERROR: The current user cannot create a table.';

