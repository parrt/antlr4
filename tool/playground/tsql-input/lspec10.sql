USE AdventureWorks ;
GO
SELECT DISTINCT Name
FROM Production.Product p 
WHERE EXISTS
(SELECT *
FROM Production.ProductModel pm 
WHERE p.ProductModelID = pm.ProductModelID
AND pm.Name = 'Long-sleeve logo jersey') ;
GO


USE AdventureWorks ;
GO
SELECT DISTINCT Name
FROM Production.Product
WHERE ProductModelID IN
(SELECT ProductModelID 
FROM Production.ProductModel
WHERE Name = 'Long-sleeve logo jersey') ;
GO

