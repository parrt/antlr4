USE AdventureWorks;
GO
IF OBJECT_ID(N'TestTran',N'U') IS NOT NULL
    DROP TABLE TestTran;
GO
CREATE TABLE TestTran (Cola INT PRIMARY KEY, Colb CHAR(3));
GO
-- This statement sets @@TRANCOUNT to 1.
BEGIN TRANSACTION OuterTran;
GO
PRINT N'Transaction count after BEGIN OuterTran = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
GO
INSERT INTO TestTran VALUES (1, 'aaa');
GO
-- This statement sets @@TRANCOUNT to 2.
BEGIN TRANSACTION Inner1;
GO
PRINT N'Transaction count after BEGIN Inner1 = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
GO
INSERT INTO TestTran VALUES (2, 'bbb');
GO
-- This statement sets @@TRANCOUNT to 3.
BEGIN TRANSACTION Inner2;
GO
PRINT N'Transaction count after BEGIN Inner2 = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
GO
INSERT INTO TestTran VALUES (3, 'ccc');
GO
-- This statement decrements @@TRANCOUNT to 2.
-- Nothing is committed.
COMMIT TRANSACTION Inner2;
GO
PRINT N'Transaction count after COMMIT Inner2 = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
GO
-- This statement decrements @@TRANCOUNT to 1.
-- Nothing is committed.
COMMIT TRANSACTION Inner1;
GO
PRINT N'Transaction count after COMMIT Inner1 = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
GO
-- This statement decrements @@TRANCOUNT to 0 and
-- commits outer transaction OuterTran.
COMMIT TRANSACTION OuterTran;
GO
PRINT N'Transaction count after COMMIT OuterTran = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
GO
