USE tempdb;
GO
SELECT PATINDEX ( '%ein%', 'Das ist ein Test'  COLLATE Latin1_General_BIN) ;
GO

