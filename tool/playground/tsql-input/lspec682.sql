USE AdventureWorks ;
GO
SELECT p.Name AS ProductName, v.Name AS VendorName
FROM Production.Product p 
INNER MERGE JOIN Purchasing.ProductVendor pv 
ON p.ProductID = pv.ProductID
INNER HASH JOIN Purchasing.Vendor v
ON pv.VendorID = v.VendorID
ORDER BY p.Name, v.Name ;


