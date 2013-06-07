USE AdventureWorks;
GO
DECLARE @rows int;
SET @rows = (SELECT COUNT(*) FROM Sales.Customer);
SELECT @rows;

