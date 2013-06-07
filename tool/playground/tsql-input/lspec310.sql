USE AdventureWorks;
GO
SELECT DISTINCT CAST(p.Name AS char(10)) AS Name, s.UnitPrice
FROM Sales.SalesOrderDetail s JOIN Production.Product p on s.ProductID = p.ProductID
WHERE Name LIKE 'Long-Sleeve Logo Jersey, M';
GO
