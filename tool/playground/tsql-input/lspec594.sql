USE AdventureWorks;
GO
SELECT i.ProductID, p.Name, i.LocationID, i.Quantity, 
    DENSE_RANK() OVER (PARTITION BY i.LocationID ORDER BY i.Quantity)     AS DENSE_RANK
FROM Production.ProductInventory i 
    JOIN Production.Product p ON i.ProductID = p.ProductID
    ORDER BY Name;
GO

