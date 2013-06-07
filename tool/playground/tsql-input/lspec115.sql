USE AdventureWorks;
GO
UPDATE HumanResources.Employee 
SET Title = N'Executive'
WHERE NationalIDNumber = 123456789
IF @@ROWCOUNT = 0
PRINT 'Warning: No rows were updated';
GO
