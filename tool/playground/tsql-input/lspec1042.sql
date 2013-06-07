BEGIN
	    WAITFOR DELAY '02:00';
	    EXECUTE sp_helpdb;
END;
GO
