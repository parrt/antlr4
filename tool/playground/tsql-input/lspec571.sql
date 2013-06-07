CREATE TABLE T1 (Col1 int, Col2 char(3));
GO
DECLARE @i int;
SELECT @i = 0
BEGIN TRAN
SELECT @i = 0
WHILE (@i < 100000)
	BEGIN
		INSERT INTO T1 VALUES (@i, CAST(@i AS char(3)))
		SELECT @i = @i + 1
	END;
COMMIT TRAN;
--Start new connection #2.
DBCC INPUTBUFFER (52); 

