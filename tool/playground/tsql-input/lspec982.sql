DECLARE @RetCode INT

EXEC @RetCode = sp_ActiveDirectory_SCP @Action = N'create'

PRINT 'Return code = ' + CAST(@RetCode AS VARCHAR)

