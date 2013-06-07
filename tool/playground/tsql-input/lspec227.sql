CREATE TABLE doc_exc ( column_a INT
CONSTRAINT my_constraint UNIQUE) ;
GO
ALTER TABLE doc_exc DROP CONSTRAINT my_constraint ;
GO
DROP TABLE doc_exc ;
GO

