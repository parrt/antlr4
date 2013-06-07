USE AdventureWorks;
GO       
SET STATISTICS TIME ON
GO
SELECT * 
FROM Production.ProductCostHistory
WHERE StandardCost < 500.00;
GO
SET STATISTICS TIME OFF;
GO

