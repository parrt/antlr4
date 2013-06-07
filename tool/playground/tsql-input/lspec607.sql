DROP ENDPOINT sql_endpoint;
USE AdventureWorks;
GO
CREATE EVENT NOTIFICATION NotifyALTER_T1
ON DATABASE
FOR ALTER_TABLE
TO SERVICE 'NotifyService',
    '8140a771-3c4b-4479-8ac0-81008ab17984';
GO
DROP EVENT NOTIFICATION NotifyALTER_T1
ON DATABASE;

DROP FULLTEXT CATALOG catalog_name
USE AdventureWorks;
GO
DROP FULLTEXT INDEX ON HumanResources.JobCandidate;
GO
USE AdventureWorks;
GO
IF OBJECT_ID (N'Sales.fn_SalesByStore', N'IF') IS NOT NULL
	    DROP FUNCTION Sales.fn_SalesByStore;
GO




