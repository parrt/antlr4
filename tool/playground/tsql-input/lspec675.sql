USE AdventureWorks ;
GO
SELECT TerritoryID, Name
FROM Sales.SalesTerritory
ORDER BY TerritoryID ;

USE AdventureWorks ;
GO
BEGIN TRAN
	SELECT COUNT(*) 
	FROM HumanResources.Employee WITH (TABLOCK, HOLDLOCK) ;


