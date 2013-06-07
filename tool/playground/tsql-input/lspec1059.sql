E AdventureWorks;
GO
DECLARE @y xml (Sales.IndividualSurveySchemaCollection)
SET @y =  (SELECT TOP 1 Demographics FROM Sales.Individual);
SELECT @y;
GO
