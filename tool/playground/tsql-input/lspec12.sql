USE AdventureWorks
GO
SELECT p1.ProductModelID
FROM Production.Product p1
GROUP BY p1.ProductModelID
HAVING MAX(p1.ListPrice) >= ALL
(SELECT 2 * AVG(p2.ListPrice)
FROM Production.Product p2
WHERE p1.ProductModelID = p2.ProductModelID) ;
GO

