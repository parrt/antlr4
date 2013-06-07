USE AdventureWorks;
GO
SELECT LOWER(SUBSTRING(Name, 1, 20)) AS Lower, 
   UPPER(SUBSTRING(Name, 1, 20)) AS Upper, 
   LOWER(UPPER(SUBSTRING(Name, 1, 20))) As LowerUpper
FROM Production.Product
WHERE ListPrice between 11.00 and 20.00;
GO

