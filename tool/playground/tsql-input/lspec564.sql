USE AdventureWorks;
GO
DBCC CHECKTABLE ('HumanResources.Employee');
GO

USE AdventureWorks;
GO
DBCC CHECKTABLE ('HumanResources.Employee') WITH PHYSICAL_ONLY;
GO

USE AdventureWorks;
GO
DECLARE @indid int;
SET @indid = (SELECT index_id 
	              FROM sys.indexes
		      WHERE object_id = OBJECT_ID('Production.Product')
			    AND name = 'AK_Product_Name');
DBCC CHECKTABLE ('Production.Product', @indid);


