CREATE TABLE doc_exd ( column_a INT) ;
GO
INSERT INTO doc_exd VALUES (-1) ;
GO
ALTER TABLE doc_exd WITH NOCHECK 
ADD CONSTRAINT exd_check CHECK (column_a > 1) ;
GO
EXEC sp_help doc_exd ;
GO
DROP TABLE doc_exd ;
GO

