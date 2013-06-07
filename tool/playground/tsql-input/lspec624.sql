USE AdventureWorks
IF OBJECT_ID ('employee_insupd', 'TR') IS NOT NULL
	   DROP TRIGGER employee_insupd
GO
USE AdventureWorks
IF EXISTS (SELECT * FROM sys.triggers
	    WHERE parent_class = 0 AND name = 'safety')
	DROP TRIGGER safety
	ON DATABASE
GO




