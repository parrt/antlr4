USE AdventureWorks;
GO
SELECT 
    INDEX_COL (N'AdventureWorks.Sales.SalesOrderDetail', 1,1) AS
        [Index Column 1], 
	    INDEX_COL (N'AdventureWorks.Sales.SalesOrderDetail', 1,2) AS
	        [Index Column 2]
		;
		GO


