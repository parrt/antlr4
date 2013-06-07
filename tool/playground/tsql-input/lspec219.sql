CREATE TABLE doc_exb ( column_a INT, column_b VARCHAR(20) NULL) ;
GO
ALTER TABLE doc_exb DROP COLUMN column_b ;
GO
EXEC sp_help doc_exb ;
GO
DROP TABLE doc_exb ;
GO

