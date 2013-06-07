USE AdventureWorks;
GO
DECLARE @MyProduct int;
SET @MyProduct = 750;
IF (@MyProduct <> 0)
	   SELECT ProductID, Name, ProductNumber
	   FROM Production.Product
	   WHERE ProductID = @MyProduct
GO

