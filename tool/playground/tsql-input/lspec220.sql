CREATE TABLE doc_exy ( column_a INT ) ;
GO
INSERT INTO doc_exy (column_a)
VALUES (10) ;
GO
ALTER TABLE doc_exy ALTER COLUMN column_a DECIMAL (5, 2) ;
GO
DROP TABLE doc_exy ;
GO

