USE AdventureWorks;
GO
DROP INDEX
    IX_PurchaseOrderHeader_EmployeeID ON Purchasing.PurchaseOrderHeader,
    IX_VendorAddress_AddressID ON Purchasing.VendorAddress;
GO


