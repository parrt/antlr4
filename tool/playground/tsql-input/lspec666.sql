SELECT * FROM fn_my_permissions(NULL, 'SERVER'); 
GO 

USE AdventureWorks;
SELECT * FROM fn_my_permissions (NULL, 'DATABASE');
GO

USE AdventureWorks;
SELECT * FROM fn_my_permissions('Sales.vIndividualCustomer', 'OBJECT') 
    ORDER BY subentity_name, permission_name ; 
GO 

EXECUTE AS USER = 'Wanida';
SELECT * FROM fn_my_permissions('HumanResources.Employee', 'OBJECT') 
    ORDER BY subentity_name, permission_name ;  
REVERT;
GO

SELECT * FROM fn_my_permissions('Shipping47', 'CERTIFICATE');
GO

USE AdventureWorks;
SELECT * FROM fn_my_permissions('ProductDescriptionSchemaCollection',
	    'XML SCHEMA COLLECTION');
GO

SELECT * FROM fn_my_permissions('MalikAr', 'USER');
GO

EXECUTE AS LOGIN = 'WanidaBenshoof';
SELECT * FROM fn_my_permissions('AdventureWorks.HumanResources.Employee', 'OBJECT') 
    ORDER BY subentity_name, permission_name ;  
REVERT;
GO



