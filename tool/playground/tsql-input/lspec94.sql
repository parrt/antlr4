USE AdventureWorks;
GO
UPDATE HumanResources.Employee 
    SET PayFrequency = 4
    WHERE NationalIDNumber = 615389812;
IF @@ERROR = 547
    PRINT N'A check constraint violation occurred.';
GO
