USE AdventureWorks ;
GO
SELECT * 
FROM Production.ProductPhoto
WHERE LargePhotoFileName LIKE '%greena_%' ESCAPE 'a' ;

