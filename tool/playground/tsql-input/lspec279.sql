USE AdventureWorks;
GO
BEGIN TRANSACTION;
GO
IF @@TRANCOUNT = 0
BEGIN
SELECT * from Person.Contact WHERE LastName = 'ADAMS';
ROLLBACK TRANSACTION
PRINT N'Rolling back the transaction two times would cause an error.'
END
ROLLBACK TRANSACTION
PRINT N'Rolled back the transaction.'
GO
/*
Rolled back the tranaction.
*/
