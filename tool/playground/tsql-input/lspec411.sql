--Verify the existing value.
SELECT Name FROM Production.UnitMeasure WHERE Name = N'Ounces';
GO
INSERT INTO Production.UnitMeasure (UnitMeasureCode, Name, ModifiedDate)
    VALUES ('OC', 'Ounces', GetDate());
