USE AdventureWorks;
GO
SET SHOWPLAN_TEXT ON;
GO
SELECT *
FROM Production.Product 
WHERE ProductID = 905;
GO
SET SHOWPLAN_TEXT OFF;
GO
SELECT *
FROM Production.Product 
WHERE ProductID = 905; 
USE AdventureWorks;
GO
SET SHOWPLAN_TEXT ON;
GO
SELECT *
FROM Production.ProductCostHistory
WHERE StandardCost < 500.00;
GO
SET SHOWPLAN_TEXT OFF;
GO
SELECT *
FROM Production.ProductCostHistory
WHERE StandardCost < 500.00; 


