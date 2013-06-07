USE AdventureWorks;
GO
SELECT Name
FROM Production.Product
WHERE CONTAINS(Name, '"chain*" OR "full*"');
GO
