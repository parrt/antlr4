DECLARE @RetCode INT

EXEC @RetCode = sp_ActiveDirectory_Obj @Action = N'create',
     @ObjType = N'database',
     @ObjName = N'AdventureWorks'

PRINT 'Return code = ' + CAST(@RetCode AS VARCHAR)

