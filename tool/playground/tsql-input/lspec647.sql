USE AdventureWorks;
GO
EXECUTE ('CREATE TABLE Sales.SalesTable (SalesID int, SalesName varchar(10));')
AS USER = 'User1';
GO

