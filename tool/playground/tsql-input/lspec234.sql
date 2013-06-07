USE AdventureWorks;
IF OBJECT_ID(N'Sales.bonus_reminder', N'TR') IS NOT NULL
    DROP TRIGGER Sales.bonus_reminder;
GO
CREATE TRIGGER bonus_reminder
ON Sales.SalesPersonQuotaHistory
WITH ENCRYPTION
AFTER INSERT, UPDATE 
AS RAISERROR ('Notify Compensation', 16, 10);
GO
-- Now, change the trigger.
USE AdventureWorks;
GO
ALTER TRIGGER Sales.bonus_reminder
ON Sales.SalesPersonQuotaHistory
AFTER INSERT
AS RAISERROR ('Notify Compensation', 16, 10);

