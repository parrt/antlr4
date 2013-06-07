USE AdventureWorks2008R2;
GO
SELECT T.[Group] AS N'Region', T.CountryRegionCode AS N'Country'
,DATEPART(yyyy,OrderDate) AS 'Year'
,DATEPART(mm,OrderDate) AS 'Month'
,SUM(TotalDue) AS N'Total Sales'
FROM Sales.Customer C
INNER JOIN Sales.Store AS S
ON C.StoreID  = S.BusinessEntityID 
INNER JOIN Sales.SalesTerritory AS T
ON C.TerritoryID  = T.TerritoryID 
INNER JOIN Sales.SalesOrderHeader AS H
ON C.CustomerID = H.CustomerID
WHERE T.[Group] = N'Europe'
AND T.CountryRegionCode IN(N'DE', N'FR')
AND DATEPART(yyyy,OrderDate) = '2006'
GROUP BY GROUPING SETS(
(T.[Group], T.CountryRegionCode)
,(DATEPART(yyyy,OrderDate), DATEPART(mm,OrderDate)))
ORDER BY T.[Group], T.CountryRegionCode
,DATEPART(yyyy,OrderDate), DATEPART(mm,OrderDate);

