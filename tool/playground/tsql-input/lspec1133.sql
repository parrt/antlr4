USE AdventureWorks2008R2;
GO
CREATE PROCEDURE dbo.InsertUnitMeasure
@UnitMeasureCode nchar(3),
@Name nvarchar(25)
AS 
BEGIN
SET NOCOUNT ON;
-- Update the row if it exists.    
UPDATE Production.UnitMeasure
SET Name = @Name
WHERE UnitMeasureCode = @UnitMeasureCode
-- Insert the row if the UPDATE statement failed.	
IF (@@ROWCOUNT = 0 )
BEGIN
INSERT INTO Production.UnitMeasure (UnitMeasureCode, Name)
VALUES (@UnitMeasureCode, @Name)
END
END;
GO
-- Test the procedure and return the results.
EXEC InsertUnitMeasure @UnitMeasureCode = 'ABC', @Name = 'Test Value';
SELECT UnitMeasureCode, Name FROM Production.UnitMeasure
WHERE UnitMeasureCode = 'ABC';
GO

-- Rewrite the procedure to perform the same operations using the MERGE statement.
-- Create a temporary table to hold the updated or inserted values from the OUTPUT clause.
CREATE TABLE #MyTempTable
(ExistingCode nchar(3),
ExistingName nvarchar(50),
ExistingDate datetime,
ActionTaken nvarchar(10),
NewCode nchar(3),
NewName nvarchar(50),
NewDate datetime
);
GO
ALTER PROCEDURE dbo.InsertUnitMeasure
@UnitMeasureCode nchar(3),
@Name nvarchar(25)
AS 
BEGIN
SET NOCOUNT ON;

MERGE Production.UnitMeasure AS target
USING (SELECT @UnitMeasureCode, @Name) AS source (UnitMeasureCode, Name)
ON (target.UnitMeasureCode = source.UnitMeasureCode)
WHEN MATCHED THEN 
UPDATE SET Name = source.Name
WHEN NOT MATCHED THEN	
INSERT (UnitMeasureCode, Name)
VALUES (source.UnitMeasureCode, source.Name)
OUTPUT deleted.*, $action, inserted.* INTO #MyTempTable;
END;
GO
-- Test the procedure and return the results.
EXEC InsertUnitMeasure @UnitMeasureCode = 'ABC', @Name = 'New Test Value';
EXEC InsertUnitMeasure @UnitMeasureCode = 'XYZ', @Name = 'Test Value';
EXEC InsertUnitMeasure @UnitMeasureCode = 'ABC', @Name = 'Another Test Value';

SELECT * FROM #MyTempTable;
-- Cleanup 
DELETE FROM Production.UnitMeasure WHERE UnitMeasureCode IN ('ABC','XYZ');
DROP TABLE #MyTempTable;
GO

