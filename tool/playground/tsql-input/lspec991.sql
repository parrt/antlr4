SELECT * FROM sys.fn_builtin_permissions(DEFAULT)
SELECT * FROM sys.fn_builtin_permissions(N'SYMMETRIC KEY')
SELECT * FROM sys.fn_builtin_permissions(DEFAULT) 
    WHERE permission_name = 'SELECT';

