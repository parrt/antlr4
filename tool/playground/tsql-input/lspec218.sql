CREATE TABLE doc_exa ( column_a INT) ;
GO
ALTER TABLE doc_exa ADD column_b VARCHAR(20) NULL ;
GO
EXEC sp_help doc_exa ;
GO
DROP TABLE doc_exa ;
GO

