USE AdventureWorks;
GO
SELECT ProductID, Name, Color, StandardCost
FROM Production.Product
WHERE ProductNumber LIKE 'BK-%' AND Color = 'Silver' AND NOT StandardCost > 400;
GO

