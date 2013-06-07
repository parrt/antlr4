SELECT *
FROM fn_virtualfilestats(1, 1);
GO

SELECT *
FROM fn_virtualfilestats(DB_ID(N'AdventureWorks'), 2);
GO

SELECT *
FROM fn_virtualfilestats(NULL,NULL);
GO


