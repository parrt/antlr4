DECLARE @db_id smallint;
DECLARE @object_id int;
SET @db_id = DB_ID(N'AdventureWorks');
SET @object_id = OBJECT_ID(N'AdventureWorks.Person.Address');
IF @db_id IS NULL 
	  BEGIN;
		    PRINT N'Invalid database';
		  END;
	ELSE IF @object_id IS NULL
		  BEGIN;
			    PRINT N'Invalid object';
			  END;
		ELSE
			  BEGIN;
				    SELECT * FROM sys.dm_db_index_operational_stats(@db_id, @object_id, NULL, NULL);
				  END;
				GO


