USE AdventureWorks;
GO
SELECT ProductID, Name, ListPrice, ListPrice * 1.15 AS NewPrice
FROM Production.Product
WHERE Name LIKE 'Mountain-%'
ORDER BY ProductID ASC;
GO
