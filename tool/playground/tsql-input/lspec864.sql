USE AdventureWorks;
GO
IF EXISTS(SELECT name FROM sys.tables
	      WHERE name = 't1')
	   DROP TABLE t1;
	GO
	CREATE TABLE t1 
	(
		 c1 varchar(3),
		 c2 char(3)
	)
	GO
	INSERT INTO t1 VALUES ('2', '2')
	INSERT INTO t1 VALUES ('37', '37')
	INSERT INTO t1 VALUES ('597', '597')
	GO
	SELECT REPLICATE('0', 3 - DATALENGTH(c1)) + c1 AS 'Varchar Column',
	       REPLICATE('0', 3 - DATALENGTH(c2)) + c2 AS 'Char Column'
	FROM t1
	GO

