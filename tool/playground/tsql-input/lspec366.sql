USE AdventureWorks;
GO
SELECT COUNT(*), AVG(Bonus)
FROM Sales.SalesPerson
WHERE SalesQuota > 25000;
GO
