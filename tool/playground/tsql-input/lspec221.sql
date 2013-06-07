CREATE TABLE doc_exc ( column_a INT) ;
GO
ALTER TABLE doc_exc ADD column_b VARCHAR(20) NULL 
    CONSTRAINT exb_unique UNIQUE ;
GO
EXEC sp_help doc_exc ;
GO
DROP TABLE doc_exc ;
GO

