USE master; EXEC ('USE AdventureWorks; SELECT EmployeeID, Title FROM HumanResources.Employee;');
USE AdventureWorks;
GO
EXEC dbo.uspGetEmployeeManagers 6;
GO
EXEC dbo.uspGetEmployeeManagers @EmployeeID = 6;
GO
dbo.uspGetEmployeeManagers 6;
GO
--Or
dbo.uspGetEmployeeManagers @EmployeeID = 6;
GO
USE AdventureWorks;
GO
DECLARE @CheckDate datetime;
SET @CheckDate = GETDATE();
EXEC dbo.uspGetWhereUsedProductID 819, @CheckDate;
GO
USE AdventureWorks;
GO
DECLARE tables_cursor CURSOR
   FOR
   SELECT s.name, t.name 
   FROM sys.objects AS t
   JOIN sys.schemas AS s ON s.schema_id = t.schema_id
   WHERE t.type = 'U';
OPEN tables_cursor;
DECLARE @schemaname sysname;
DECLARE @tablename sysname;
FETCH NEXT FROM tables_cursor INTO @schemaname, @tablename;
WHILE (@@FETCH_STATUS <> -1)
	BEGIN;
		   EXEC ('ALTER INDEX ALL ON ' + @schemaname + '.' + @tablename + ' REBUILD;');
		   FETCH NEXT FROM tables_cursor INTO @schemaname, @tablename;
	END;
PRINT 'The indexes on all tables have been rebuilt.';
CLOSE tables_cursor;
DEALLOCATE tables_cursor;
GO
	
DECLARE @retstat int;
EXECUTE @retstat = SQLSERVER1.AdventureWorks.dbo.uspGetEmployeeManagers @EmployeeID = 6;

DECLARE @proc_name varchar(30);
SET @proc_name = 'sys.sp_who';
EXEC @proc_name;

USE AdventureWorks;
GO
IF OBJECT_ID(N'dbo.ProcTestDefaults', N'P')IS NOT NULL
	   DROP PROCEDURE dbo.ProcTestDefaults;
	GO
	-- Create the stored procedure.
CREATE PROCEDURE dbo.ProcTestDefaults (
	    @p1 smallint = 42, 
	    @p2 char(1), 
	    @p3 varchar(8) = 'CAR')
    AS 
   SELECT @p1, @p2, @p3
;
GO

-- Specifying a value only for one parameter (@p2).
EXECUTE dbo.ProcTestDefaults @p2 = 'A';
-- Specifying a value for the first two parameters.
EXECUTE dbo.PProcTestDefaultss 68, 'B';
-- Specifying a value for all three parameters.
EXECUTE dbo.ProcTestDefaultss 68, 'C', 'House';
-- Using the DEFAULT keyword for the first parameter.
EXECUTE dbo.ProcTestDefaults @p1 = DEFAULT, @p2 = 'D';
-- Specifying the parameters in an order different from the order defined in the procedure.
EXECUTE dbo.PProcTestDefaults DEFAULT, @p3 = 'Local', @p2 = 'E';
-- Using the DEFAULT keyword for the first and third parameters.
EXECUTE dbo.ProcTestDefaults DEFAULT, 'H', DEFAULT;
EXECUTE dbo.ProcTestDefaults DEFAULT, 'I', @p3 = DEFAULT;

EXEC sp_addlinkedserver 'SeattleSales', 'SQL Server'
GO
EXECUTE ( 'CREATE TABLE AdventureWorks.dbo.SalesTbl 
	(SalesID int, SalesName varchar(10)) ; ' ) AT SeattleSales;
GO

EXECUTE dbo.Proc_Test_Defaults @p2 = 'A' WITH RECOMPILE;
GO

USE AdventureWorks;
GO
DECLARE @returnstatus nvarchar(15);
SET @returnstatus = NULL;
EXEC @returnstatus = dbo.ufnGetSalesOrderStatusText @Status = 2;
PRINT @returnstatus;
GO


