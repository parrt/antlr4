USE AdventureWorks ;
GO
IF OBJECT_ID ('PurchaseOrderReject', 'V') IS NOT NULL
DROP VIEW PurchaseOrderReject ;
GO
CREATE VIEW PurchaseOrderReject
WITH ENCRYPTION
AS
SELECT PurchaseOrderID, ReceivedQty, RejectedQty, RejectedQty / ReceivedQty AS RejectRatio
FROM Purchasing.PurchaseOrderDetail
WHERE RejectedQty / ReceivedQty > 0
AND DueDate > '06/30/2001' ;
GO

