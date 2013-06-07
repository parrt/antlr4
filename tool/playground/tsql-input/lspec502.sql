IF OBJECT_ID ('Purchasing.LowCredit','TR') IS NOT NULL
   DROP TRIGGER Purchasing.LowCredit
GO
CREATE TRIGGER LowCredit ON Purchasing.PurchaseOrderHeader
AFTER INSERT
AS
DECLARE @creditrating tinyint,
   @vendorid int
SELECT @creditrating = v.CreditRating, @vendorid = p.VendorID
FROM Purchasing.PurchaseOrderHeader p INNER JOIN inserted i ON p.PurchaseOrderID =
   i.PurchaseOrderID JOIN Purchasing.Vendor v on v.VendorID = i.VendorID
IF @creditrating = 5
BEGIN
   RAISERROR ('This vendor''s credit rating is too low to accept new
      purchase orders.', 16, 1)
ROLLBACK TRANSACTION
END

