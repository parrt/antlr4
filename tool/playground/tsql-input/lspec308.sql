USE AdventureWorks;
GO
SELECT CAST(ROUND(SalesYTD/CommissionPCT, 0) AS int) AS 'Computed'
FROM Sales.SalesPerson 
WHERE CommissionPCT != 0;
GO
