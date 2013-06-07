USE AdventureWorks;
GO
SELECT Description
FROM Production.ProductDescription
WHERE CONTAINS(Description, ' FORMSOF (INFLECTIONAL, ride) ');
GO
