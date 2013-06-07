USE AdventureWorks;
GO
SELECT length = DATALENGTH(Name), Name
FROM Production.Product
ORDER BY Name;
GO

