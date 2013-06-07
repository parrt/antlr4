USE AdventureWorks;
GO
IF OBJECT_ID ( 'Purchasing.uspVendorAllInfo', 'P' ) IS NOT NULL 
    DROP PROCEDURE Purchasing.uspVendorAllInfo;
GO
CREATE PROCEDURE Purchasing.uspVendorAllInfo
WITH EXECUTE AS CALLER
AS
    SELECT v.Name AS Vendor, p.Name AS 'Product name', 
      v.CreditRating AS 'Credit Rating', 
      v.ActiveFlag AS Availability
    FROM Purchasing.Vendor v 
    INNER JOIN Purchasing.ProductVendor pv
      ON v.VendorID = pv.VendorID 
    INNER JOIN Production.Product p
      ON pv.ProductID = p.ProductID 
    ORDER BY v.Name ASC;
GO

