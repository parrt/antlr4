USE tempdb;
GO
-- Create a synonym for the Product table in AdventureWorks.
CREATE SYNONYM MyProduct
FOR AdventureWorks.Production.Product;
GO
-- Drop synonym MyProduct.
USE tempdb;
GO
DROP SYNONYM MyProduct;
GO

