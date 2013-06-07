USE AdventureWorks;
GO
SELECT LEN(FirstName) AS Length, FirstName, LastName 
FROM Sales.vIndividualCustomer
WHERE CountryRegionName = 'Australia';
GO

