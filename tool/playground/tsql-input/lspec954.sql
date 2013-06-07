USE AdventureWorks;
GO       
SET STATISTICS IO ON;
GO
SELECT * 
FROM Production.ProductCostHistory
WHERE StandardCost < 500.00;
GO
SET STATISTICS IO OFF;
GO

