USE AdventureWorks ;
GO

SELECT * INTO dbo.NewProducts
FROM Production.Product
WHERE ListPrice > $25 
AND ListPrice < $100

SELECT name 
FROM sysobjects 
WHERE name LIKE 'New%'

USE master ;
GO

GO

