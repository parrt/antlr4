SELECT has_perms_by_name(null, null, 'VIEW SERVER STATE');
SELECT has_perms_by_name('Ps', 'LOGIN', 'IMPERSONATE')

SELECT has_perms_by_name(db_name(), 'DATABASE', 'ANY')

EXECUTE AS user = 'Pd'
GO
SELECT has_perms_by_name(db_name(), 'DATABASE', 'ANY')

GO
REVERT
GO

SELECT has_perms_by_name(db_name(), 'DATABASE', 'CREATE PROCEDURE')
    & has_perms_by_name('S', 'SCHEMA', 'ALTER') AS _can_create_procs,
    has_perms_by_name(db_name(), 'DATABASE', 'CREATE TABLE') &
    has_perms_by_name('S', 'SCHEMA', 'ALTER') AS _can_create

SELECT has_perms_by_name(SCHEMA_NAME(schema_id) + '.' + name, 
	    'OBJECT', 'SELECT') AS have_select, * FROM sys.tables;

SELECT has_perms_by_name('Sales.SalesPerson', 'OBJECT', 'INSERT')

SELECT has_perms_by_name('AdventureWorks.Sales.SalesPerson', 
	    'OBJECT', 'INSERT')

SELECT name AS column_name, 
    has_perms_by_name('T', 'OBJECT', 'SELECT', name, 'COLUMN') 
    AS can_select FROM sys.columns AS c 
    WHERE c.object_id=object_id('T');

