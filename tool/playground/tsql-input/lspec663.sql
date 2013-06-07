DECLARE @Handle varbinary(64);
SELECT @Handle = sql_handle 
FROM sys.dm_exec_requests 
WHERE session_id = 52 and request_id = 0;
SELECT * FROM sys.fn_get_sql(@Handle);
GO

