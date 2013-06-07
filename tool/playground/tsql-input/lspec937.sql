DECLARE @deadlock_var NCHAR(3);
SET @deadlock_var = N'LOW';

SET DEADLOCK_PRIORITY @deadlock_var;
GO
SET DEADLOCK_PRIORITY NORMAL;
GO

