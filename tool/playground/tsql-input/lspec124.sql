USE AdventureWorks;
GO
BEGIN TRANSACTION;
GO
UPDATE Person.Contact
    SET LastName = UPPER(LastName)
    WHERE LastName = 'Wood';
GO
IF @@TRANCOUNT > 0
BEGIN
    PRINT N'A transaction needs to be rolled back.';
    ROLLBACK TRANSACTION;
END
