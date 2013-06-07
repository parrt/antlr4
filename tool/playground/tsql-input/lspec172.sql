--Change to accent insensitive
USE AdventureWorks;
GO
ALTER FULLTEXT CATALOG ftCatalog 
REBUILD WITH ACCENT_SENSITIVITY=OFF;
GO
-- Check Accentsensitivity
SELECT FULLTEXTCATALOGPROPERTY('ftCatalog', 'accentsensitivity');
GO
--Returned 0, which means the catalog is not accent sensitive.
