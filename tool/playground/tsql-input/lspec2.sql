USE AdventureWorks ;
GO
SELECT *
FROM Production.Product
ORDER BY Name ASC ;
-- Alternate way.
USE AdventureWorks ;
GO
SELECT p.*
FROM Production.Product p
ORDER BY Name ASC ;
GO

