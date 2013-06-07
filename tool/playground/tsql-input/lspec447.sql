USE AdventureWorks;
GO
IF OBJECT_ID ( 'dbo.uspproduct_by_vendor', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.uspProductByVendor;
GO
CREATE PROCEDURE dbo.uspProductByVendor @Name varchar(30) = '%'
WITH RECOMPILE
AS
    SELECT v.Name AS 'Vendor name', p.Name AS 'Product name'
    FROM Purchasing.Vendor AS v 
    JOIN Purchasing.ProductVendor AS pv 
      ON v.VendorID = pv.VendorID 
    JOIN Production.Product AS p 
      ON pv.ProductID = p.ProductID
    WHERE v.Name LIKE @Name;
GO

