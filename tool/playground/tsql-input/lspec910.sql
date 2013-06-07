USE AdventureWorks ;       
GO       
DECLARE @var1 nvarchar(30);       
SELECT @var1 = 'Generic Name';       
SELECT @var1 = Name       
FROM Sales.Store       
WHERE CustomerID = 1000 ;      
SELECT @var1 AS 'Company Name';

