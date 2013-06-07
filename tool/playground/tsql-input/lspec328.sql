--Get the checksum value before the column value is changed.
USE AdventureWorks;
GO
SELECT CHECKSUM_AGG(CAST(Quantity AS int))
FROM Production.ProductInventory;
GO
