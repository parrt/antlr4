USE AdventureWorks2008R2;
GO
IF OBJECT_ID (N'Production.usp_UpdateInventory', N'P') IS NOT NULL DROP PROCEDURE Production.usp_UpdateInventory;
GO
CREATE PROCEDURE Production.usp_UpdateInventory
@OrderDate datetime
AS
MERGE Production.ProductInventory AS target
USING (SELECT ProductID, SUM(OrderQty) FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
AND soh.OrderDate = @OrderDate
GROUP BY ProductID) AS source (ProductID, OrderQty)
ON (target.ProductID = source.ProductID)
WHEN MATCHED AND target.Quantity - source.OrderQty <= 0
THEN DELETE
WHEN MATCHED 
THEN UPDATE SET target.Quantity = target.Quantity - source.OrderQty, 
target.ModifiedDate = GETDATE()
OUTPUT $action, Inserted.ProductID, Inserted.Quantity, Inserted.ModifiedDate, Deleted.ProductID,
Deleted.Quantity, Deleted.ModifiedDate;
GO

EXECUTE Production.usp_UpdateInventory '20030501'

