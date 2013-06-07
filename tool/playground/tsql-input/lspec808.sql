USE AdventureWorks;
GO
IF OBJECTPROPERTY (OBJECT_ID(N'Production.UnitMeasure'),'ISTABLE') = 1
	   PRINT 'UnitMeasure is a table.'
ELSE IF OBJECTPROPERTY (OBJECT_ID(N'Production.UnitMeasure'),'ISTABLE') = 0
	   PRINT 'UnitMeasure is not a table.'
ELSE IF OBJECTPROPERTY (OBJECT_ID(N'Production.UnitMeasure'),'ISTABLE') IS NULL
	   PRINT 'ERROR: UnitMeasure is not a valid object.';
	GO


