USE AdventureWorks;
GO
IF OBJECT_ID ( 'Production.uspGetList', 'P' ) IS NOT NULL 
    DROP PROCEDURE Production.uspGetList;
GO
CREATE PROCEDURE Production.uspGetList @Product varchar(40) 
    , @MaxPrice money 
    , @ComparePrice money OUTPUT
    , @ListPrice money OUT
AS
    SELECT p.[Name] AS Product, p.ListPrice AS 'List Price'
    FROM Production.Product AS p
    JOIN Production.ProductSubcategory AS s 
      ON p.ProductSubcategoryID = s.ProductSubcategoryID
    WHERE s.[Name] LIKE @Product AND p.ListPrice < @MaxPrice;
-- Populate the output variable @ListPprice.
SET @ListPrice = (SELECT MAX(p.ListPrice)
        FROM Production.Product AS p
        JOIN  Production.ProductSubcategory AS s 
          ON p.ProductSubcategoryID = s.ProductSubcategoryID
        WHERE s.[Name] LIKE @Product AND p.ListPrice < @MaxPrice);
-- Populate the output variable @compareprice.
SET @ComparePrice = @MaxPrice;
GO

