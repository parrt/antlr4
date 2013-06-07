USE AdventureWorks;
GO
SELECT AVG(ISNULL(Weight, 50))
FROM Production.Product;
GO

