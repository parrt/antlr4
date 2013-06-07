USE AdventureWorks;
GO
UPDATE Production.Product
SET Color = N'Metallic Red'
WHERE Name LIKE N'Road-250%' AND Color = N'Red';
GO

USE AdventureWorks;
GO
UPDATE Sales.SalesPerson
SET SalesYTD = SalesYTD + SubTotal
FROM Sales.SalesPerson AS sp
JOIN Sales.SalesOrderHeader AS so
    ON sp.SalesPersonID = so.SalesPersonID
    AND so.OrderDate = (SELECT MAX(OrderDate)
FROM Sales.SalesOrderHeader 
WHERE SalesPersonID = 
	      sp.SalesPersonID);
GO
