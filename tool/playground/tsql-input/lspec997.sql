CREATE TABLE t1 (c1 int, c2 text)
EXEC sp_tableoption 't1', 'text in row', 'on'
INSERT t1 VALUES ('1', 'This is text.')
GO
BEGIN TRAN
	   DECLARE @ptrval VARBINARY(16)
	   SELECT @ptrval = TEXTPTR(c2)
	   FROM t1
	   WHERE c1 = 1
	   READTEXT t1.c2 @ptrval 0 1
	COMMIT

