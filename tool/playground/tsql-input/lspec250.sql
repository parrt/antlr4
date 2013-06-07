USE AdventureWorks;
GO
BEGIN TRAN;
DECLARE @result int;
EXEC @result=sp_getapplock
    @DbPrincipal='public',
    @Resource='Form1',
    @LockMode='Shared',
    @LockOwner='Transaction';
SELECT APPLOCK_MODE('public', 'Form1', 'Transaction');
GO
