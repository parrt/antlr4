USE AdventureWorks;
GO
DECLARE @returnstatus nvarchar(15);
SET @returnstatus = NULL;
EXEC @returnstatus = dbo.ufnGetSalesOrderStatusText @Status = 2;
PRINT @returnstatus;
GO

