USE AdventureWorks;
GO
IF OBJECT_ID ('dbo.T1', 'U') IS NOT NULL
	    DROP TABLE dbo.T1;
	GO
	CREATE TABLE dbo.T1 
	(
		    column_1 int IDENTITY, 
		    column_2 varchar(30) 
		        CONSTRAINT default_name DEFAULT ('my column default'),
			    column_3 timestamp,
			    column_4 varchar(40) NULL
		);
		GO
		INSERT INTO dbo.T1 (column_4) 
		    VALUES ('Explicit value');
		INSERT INTO dbo.T1 (column_2, column_4) 
		    VALUES ('Explicit value', 'Explicit value');
		INSERT INTO dbo.T1 (column_2) 
		    VALUES ('Explicit value');
		INSERT INTO T1 DEFAULT VALUES; 
		GO
		SELECT column_1, column_2, column_3, column_4
		FROM dbo.T1;
		GO


