USE AdventureWorks;
GO
DECLARE @SearchWord varchar(30)
SET @SearchWord ='performance'
SELECT Description 
FROM Production.ProductDescription 
WHERE CONTAINS(Description, @SearchWord);

