-- Create the statistics groups.
USE AdventureWorks;
GO
CREATE STATISTICS VendorCredit
    ON Purchasing.Vendor (Name, CreditRating)
    WITH SAMPLE 50 PERCENT
CREATE STATISTICS CustomerTotal
    ON Sales.SalesOrderHeader (CustomerID, TotalDue)
    WITH FULLSCAN;
GO
DROP STATISTICS Purchasing.Vendor.VendorCredit, Sales.SalesOrderHeader.CustomerTotal;


