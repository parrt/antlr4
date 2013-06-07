UPDATE Production.ProductInventory 
SET Quantity=125
WHERE Quantity=100;
GO
--Get the checksum of the modified column.
SELECT CHECKSUM_AGG(CAST(Quantity AS int))
FROM Production.ProductInventory;
