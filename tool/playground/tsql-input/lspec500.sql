USE AdventureWorks
IF OBJECT_ID ('Sales.reminder1', 'TR') IS NOT NULL
   DROP TRIGGER Sales.reminder1
GO
CREATE TRIGGER reminder1
ON Sales.Customer
AFTER INSERT, UPDATE 
AS RAISERROR ('Notify Customer Relations', 16, 10)
GO

