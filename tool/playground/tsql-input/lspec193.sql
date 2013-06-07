ALTER PROCEDURE Purchasing.uspVendorAllInfo
    @Product varchar(25) 
AS
    SELECT LEFT(v.Name, 25) AS Vendor, LEFT(p.Name, 25) AS 'Product name', 
    'Credit rating' = CASE v.CreditRating 
        WHEN 1 THEN 'Superior'
        WHEN 2 THEN 'Excellent'
        WHEN 3 THEN 'Above average'
        WHEN 4 THEN 'Average'
        WHEN 5 THEN 'Below average'
        ELSE 'No rating'
        END
    , Availability = CASE v.ActiveFlag
        WHEN 1 THEN 'Yes'
        ELSE 'No'
        END
    FROM Purchasing.Vendor AS v 
    INNER JOIN Purchasing.ProductVendor AS pv
      ON v.VendorID = pv.VendorID 
    INNER JOIN Production.Product AS p 
      ON pv.ProductID = p.ProductID 
    WHERE p.Name LIKE @Product
    ORDER BY v.Name ASC;
GO
EXEC Purchasing.uspVendorAllInfo N'LL Crankarm';
GO
