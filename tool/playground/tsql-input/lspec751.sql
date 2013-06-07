USE AdventureWorks;
GO
IF OBJECT_ID ('dbo.T1', 'U') IS NOT NULL
	    DROP TABLE dbo.T1;
	GO
	CREATE TABLE dbo.T1 
	(
		    column_1 int IDENTITY, 
		    column_2 uniqueidentifier,
	);
	GO
	INSERT INTO dbo.T1 (column_2) 
	    VALUES (NEWID());
	INSERT INTO T1 DEFAULT VALUES; 
	GO
	SELECT column_1, column_2
	FROM dbo.T1;
	GO


