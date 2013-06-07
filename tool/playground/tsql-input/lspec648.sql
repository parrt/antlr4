-- Setup the linked server.
EXEC sp_addlinkedserver 'SeattleSales', 'SQL Server'
GO
-- Execute the SELECT statement.
EXECUTE ('SELECT ProductID, Name 
	    FROM AdventureWorks.Production.Product
	    WHERE ProductID = ? ', 952) AT SeattleSales;
GO

