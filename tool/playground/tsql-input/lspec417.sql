USE AdventureWorks;
GO
IF EXISTS (SELECT * FROM sys.indexes
            WHERE name = N'PXML_ProductModel_CatalogDescription')
    DROP INDEX PXML_ProductModel_CatalogDescription 
        ON Production.ProductModel;
GO
CREATE PRIMARY XML INDEX PXML_ProductModel_CatalogDescription
    ON Production.ProductModel (CatalogDescription);
GO

