USE AdventureWorks;
GO
IF OBJECT_ID ( 'dbo.uspProc1', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.uspProc1;
GO
CREATE PROCEDURE dbo.uspProc1
AS
    SELECT column1, column2 FROM table_does_not_exist
GO

