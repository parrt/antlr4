USE AdventureWorks;
GO
DECLARE @SearchWord nvarchar(30)
SET @SearchWord = N'performance'
SELECT Description 
FROM Production.ProductDescription 
WHERE CONTAINS(Description, @SearchWord);

