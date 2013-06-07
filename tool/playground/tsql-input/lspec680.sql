USE AdventureWorks ;
GO
SELECT st.Name AS Territory, sp.SalesPersonID
FROM Sales.SalesTerritory st 
RIGHT OUTER JOIN Sales.SalesPerson sp
ON st.TerritoryID = sp.TerritoryID ;


