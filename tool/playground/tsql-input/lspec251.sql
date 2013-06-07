Use AdventureWorks;
GO
BEGIN TRAN;
SELECT APPLOCK_MODE('public', 'Form1', 'Transaction');
--Result set: NoLock

SELECT APPLOCK_TEST('public', 'Form1', 'Shared', 'Transaction');
--Result set: 1 (Lock is grantable.)

SELECT APPLOCK_TEST('public', 'Form1', 'Exclusive', 'Transaction');
--Result set: 0 (Lock is not grantable.)
GO
