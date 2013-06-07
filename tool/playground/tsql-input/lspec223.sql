CREATE TABLE doc_exz ( column_a INT, column_b INT) ;
GO
INSERT INTO doc_exz (column_a)
VALUES ( 7 ) ;
GO
ALTER TABLE doc_exz
ADD CONSTRAINT col_b_def
DEFAULT 50 FOR column_b ;
GO
INSERT INTO doc_exz (column_a)
VALUES ( 10 ) ;
GO
SELECT * FROM doc_exz ;
GO
DROP TABLE doc_exz ;
GO

