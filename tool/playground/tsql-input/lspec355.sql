USE AdventureWorks;
GO
SELECT Description
FROM Production.ProductDescription
WHERE CONTAINS(Description, 'bike NEAR performance');
GO
