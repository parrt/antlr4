USE AdventureWorks;
GO
SELECT TerritoryID, AVG(Bonus)as 'Average bonus', SUM(SalesYTD) 'YTD sales'
FROM Sales.SalesPerson
GROUP BY TerritoryID;
GO
