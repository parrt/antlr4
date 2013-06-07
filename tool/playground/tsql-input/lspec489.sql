USE tempdb;
GO
-- Create a synonym for the Product table in AdventureWorks.
CREATE SYNONYM MyProduct
FOR AdventureWorks.Production.Product;
GO

-- Query the Product table by using the synonym.
USE tempdb;
GO
SELECT ProductID, Name 
FROM MyProduct
WHERE ProductID < 5;
GO
