DBCC CLEANTABLE ('AdventureWorks','Production.Document', 0)
WITH NO_INFOMSGS;
GO

USE AdventureWorks;
GO
IF OBJECT_ID ('dbo.CleanTableTest', 'U') IS NOT NULL
	    DROP TABLE dbo.CleanTableTest;
	GO
	CREATE TABLE dbo.CleanTableTest
	    (DocumentID int Not Null,
		    FileName nvarchar(4000), 
		    DocumentSummary nvarchar(max),
		    Document varbinary(max)
		    );
		GO
		-- Populate the table with data from the Production.Document table.
INSERT INTO dbo.CleanTableTest
    SELECT DocumentID,
           REPLICATE(FileName, 1000), 
	           DocumentSummary, 
		           Document
			    FROM Production.Document;
			GO
			-- Verify the current page counts and average space used in the dbo.CleanTableTest table.
DECLARE @db_id SMALLINT;
DECLARE @object_id INT;
SET @db_id = DB_ID(N'AdventureWorks');
SET @object_id = OBJECT_ID(N'AdventureWorks.dbo.CleanTableTest');
SELECT alloc_unit_type_desc, 
       page_count, 
       avg_page_space_used_in_percent, 
       record_count
FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'Detailed');
GO
-- Drop two variable-length columns from the table.
ALTER TABLE dbo.CleanTableTest
DROP COLUMN FileName, Document;
GO
-- Verify the page counts and average space used in the dbo.CleanTableTest table
-- Notice that the values have not changed.
DECLARE @db_id SMALLINT;
DECLARE @object_id INT;
SET @db_id = DB_ID(N'AdventureWorks');
SET @object_id = OBJECT_ID(N'AdventureWorks.dbo.CleanTableTest');
SELECT alloc_unit_type_desc, 
       page_count, 
       avg_page_space_used_in_percent, 
       record_count
FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'Detailed');
GO
-- Run DBCC CLEANTABLE.
DBCC CLEANTABLE ('AdventureWorks','dbo.CleanTableTest');
GO
-- Verify the values in the dbo.CleanTableTest table after the DBCC CLEANTABLE command.
DECLARE @db_id SMALLINT;
DECLARE @object_id INT;
SET @db_id = DB_ID(N'AdventureWorks');
SET @object_id = OBJECT_ID(N'AdventureWorks.dbo.CleanTableTest');
SELECT alloc_unit_type_desc, 
       page_count, 
       avg_page_space_used_in_percent, 
       record_count
FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'Detailed');
GO


