USE AdventureWorks2008R2;
GO
SELECT T.[Group] AS N'Region', T.CountryRegionCode AS N'Country'
,S.Name AS N'Store', H.SalesPersonID
,SUM(TotalDue) AS N'Total Sales'
FROM Sales.Customer C
INNER JOIN Sales.Store AS S
ON C.StoreID  = S.BusinessEntityId 
INNER JOIN Sales.SalesTerritory AS T
ON C.TerritoryID  = T.TerritoryID 
INNER JOIN Sales.SalesOrderHeader AS H
ON C.CustomerID = H.CustomerID
WHERE T.[Group] = N'Europe'
AND T.CountryRegionCode IN(N'DE', N'FR')
AND H.SalesPersonID IN(287, 288, 290)
AND SUBSTRING(S.Name,1,4)IN(N'Vers', N'Spa ')
GROUP BY GROUPING SETS
(T.[Group], T.CountryRegionCode, S.Name, H.SalesPersonID)
ORDER BY T.[Group], T.CountryRegionCode, S.Name, H.SalesPersonID;

