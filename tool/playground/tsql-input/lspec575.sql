USE AdventureWorks;
GO
DBCC SHOWCONTIG ('HumanResources.Employee');
GO

USE AdventureWorks;
GO
DECLARE @id int, @indid int
SET @id = OBJECT_ID('Production.Product')
SELECT @indid = index_id 
FROM sys.indexes
WHERE object_id = @id 
   AND name = 'AK_Product_Name'
DBCC SHOWCONTIG (@id, @indid);
GO

USE AdventureWorks;
GO
DBCC SHOWCONTIG ('Production.Product', 1) WITH FAST;
GO

USE AdventureWorks;
GO
DBCC SHOWCONTIG WITH TABLERESULTS, ALL_INDEXES;
GO

/*Perform a 'USE <database name>' to select the database in which to run the script.*/
-- Declare variables
SET NOCOUNT ON;
DECLARE @tablename varchar(128);
DECLARE @execstr   varchar(255);
DECLARE @objectid  int;
DECLARE @indexid   int;
DECLARE @frag      decimal;
DECLARE @maxfrag   decimal;

-- Decide on the maximum fragmentation to allow for.
SELECT @maxfrag = 30.0;

-- Declare a cursor.
DECLARE tables CURSOR FOR
   SELECT TABLE_NAME
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE';

-- Create the table.
CREATE TABLE #fraglist (
	   ObjectName char(255),
	   ObjectId int,
	   IndexName char(255),
	   IndexId int,
	   Lvl int,
	   CountPages int,
	   CountRows int,
	   MinRecSize int,
	   MaxRecSize int,
	   AvgRecSize int,
	   ForRecCount int,
	   Extents int,
	   ExtentSwitches int,
	   AvgFreeBytes int,
	   AvgPageDensity int,
	   ScanDensity decimal,
	   BestCount int,
	   ActualCount int,
	   LogicalFrag decimal,
	   ExtentFrag decimal);

-- Open the cursor.
OPEN tables;

-- Loop through all the tables in the database.
FETCH NEXT
   FROM tables
   INTO @tablename;

WHILE @@FETCH_STATUS = 0
	BEGIN;
		-- Do the showcontig of all indexes of the table
   INSERT INTO #fraglist 
   EXEC ('DBCC SHOWCONTIG (''' + @tablename + ''') 
	      WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS');
   FETCH NEXT
      FROM tables
      INTO @tablename;
END;

-- Close and deallocate the cursor.
CLOSE tables;
DEALLOCATE tables;

-- Declare the cursor for the list of indexes to be defragged.
DECLARE indexes CURSOR FOR
   SELECT ObjectName, ObjectId, IndexId, LogicalFrag
   FROM #fraglist
   WHERE LogicalFrag >= @maxfrag
      AND INDEXPROPERTY (ObjectId, IndexName, 'IndexDepth') > 0;

-- Open the cursor.
OPEN indexes;

-- Loop through the indexes.
FETCH NEXT
   FROM indexes
   INTO @tablename, @objectid, @indexid, @frag;

WHILE @@FETCH_STATUS = 0
	BEGIN;
		   PRINT 'Executing DBCC INDEXDEFRAG (0, ' + RTRIM(@tablename) + ',
			      ' + RTRIM(@indexid) + ') - fragmentation currently '
		       + RTRIM(CONVERT(varchar(15),@frag)) + '%';
		   SELECT @execstr = 'DBCC INDEXDEFRAG (0, ' + RTRIM(@objectid) + ',
			       ' + RTRIM(@indexid) + ')';
		   EXEC (@execstr);

		   FETCH NEXT
		      FROM indexes
		      INTO @tablename, @objectid, @indexid, @frag;
	END;

	-- Close and deallocate the cursor.
CLOSE indexes;
DEALLOCATE indexes;

-- Delete the temporary table.
DROP TABLE #fraglist;
GO


