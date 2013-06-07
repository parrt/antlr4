EXEC sp_dropserver 'current_server_name';
GO
EXEC sp_addserver 'new_server_name', 'local';
GO
SELECT CONVERT(char(20), SERVERPROPERTY('servername'));
GO

