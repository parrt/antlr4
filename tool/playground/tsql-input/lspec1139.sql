USE AdventureWorks2008R2;
GO

/* Create a table type. */
CREATE TYPE LocationTableType AS TABLE 
( LocationName VARCHAR(50)
, CostRate INT );
GO

/* Create a procedure to receive data for the table-valued parameter. */
CREATE PROCEDURE usp_InsertProductionLocation
@TVP LocationTableType READONLY
AS 
SET NOCOUNT ON
INSERT INTO [AdventureWorks2008R2].[Production].[Location]
([Name]
,[CostRate]
,[Availability]
,[ModifiedDate])
SELECT *, 0, GETDATE()
FROM  @TVP;
GO

/* Declare a variable that references the type. */
DECLARE @LocationTVP 
AS LocationTableType;

/* Add data to the table variable. */
INSERT INTO @LocationTVP (LocationName, CostRate)
SELECT [Name], 0.00
FROM 
[AdventureWorks2008R2].[Person].[StateProvince];

/* Pass the table variable data to a stored procedure. */
EXEC usp_InsertProductionLocation @LocationTVP;
GO

