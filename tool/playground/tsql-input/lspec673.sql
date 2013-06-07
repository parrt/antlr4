USE AdventureWorks;
GO
DECLARE @SearchWord varchar(30)
SET @SearchWord ='performance'
SELECT Description 
FROM Production.ProductDescription 
WHERE FREETEXT(Description, @SearchWord);

USE AdventureWorks;
GO
DECLARE @SearchWord nvarchar(30)
SET @SearchWord = N'performance'
SELECT Description 
FROM Production.ProductDescription 
WHERE FREETEXT(Description, @SearchWord);

USE AdventureWorks;
GO
SELECT Title
FROM Production.Document
WHERE FREETEXT (Document, 'vital safety components' );
GO

USE AdventureWorks;
GO
DECLARE @SearchWord nvarchar(30);
SET @SearchWord = N'high-performance';
SELECT Description 
FROM Production.ProductDescription 
WHERE FREETEXT(Description, @SearchWord);
GO

