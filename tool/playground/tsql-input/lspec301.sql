DECLARE @bulk_cmd varchar(1000)
SET @bulk_cmd = 'BULK INSERT AdventureWorks.Sales.SalesOrderDetail
FROM ''<drive>:\<path>\<filename>'' 
WITH (ROWTERMINATOR = '''+CHAR(10)+''')'
EXEC(@bulk_cmd)
