DROP TYPE ssn ;
USE AdventureWorks;
DROP USER AbolrousHazem;
GO
USE AdventureWorks ;
GO
IF OBJECT_ID ('Reorder', 'view') IS NOT NULL
	DROP VIEW Reorder ;
GO
DROP XML SCHEMA COLLECTION ManuInstructionsSchemaCollection
GO



