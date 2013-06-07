USE AdventureWorks;
GO
UPDATE Sales.SalesPerson
SET Bonus = 6000, CommissionPct = .10, SalesQuota = NULL;
GO

USE AdventureWorks ;
GO
UPDATE Production.Product
SET ListPrice = ListPrice * 2;
GO

