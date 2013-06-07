USE AdventureWorks;
GO
IF EXISTS (SELECT name from sys.indexes
             WHERE name = N'AK_UnitMeasure_Name')
    DROP INDEX AK_UnitMeasure_Name ON Production.UnitMeasure;
GO
CREATE UNIQUE INDEX AK_UnitMeasure_Name 
    ON Production.UnitMeasure(Name);
GO

