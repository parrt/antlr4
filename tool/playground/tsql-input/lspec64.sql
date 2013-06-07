USE AdventureWorks;
GO
SELECT MAX(TaxRate) - MIN(TaxRate) AS 'Tax Rate Difference'
FROM Sales.SalesTaxRate
WHERE StateProvinceID IS NOT NULL;
GO
