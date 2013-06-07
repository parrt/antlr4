-- Create table t1 and insert values.
CREATE TABLE t1 (a INT NULL)
INSERT INTO t1 values (NULL)
INSERT INTO t1 values (0)
INSERT INTO t1 values (1)
GO

-- Print message and perform SELECT statements.
PRINT 'Testing default setting'
DECLARE @varname int
SELECT @varname = NULL
SELECT * 
FROM t1 
WHERE a = @varname
SELECT * 
FROM t1 
WHERE a <> @varname
SELECT * 
FROM t1 
WHERE a IS NULL
GO

-- SET ANSI_NULLS to ON and test.
PRINT 'Testing ANSI_NULLS ON'
SET ANSI_NULLS ON
GO
DECLARE @varname int
SELECT @varname = NULL
SELECT * 
FROM t1 
WHERE a = @varname
SELECT * 
FROM t1 
WHERE a <> @varname
SELECT * 
FROM t1 
WHERE a IS NULL
GO

-- SET ANSI_NULLS to OFF and test.
PRINT 'Testing SET ANSI_NULLS OFF'
SET ANSI_NULLS OFF
GO
DECLARE @varname int
SELECT @varname = NULL
SELECT * 
FROM t1 
WHERE a = @varname
SELECT * 
FROM t1 
WHERE a <> @varname
SELECT * 
FROM t1 
WHERE a IS NULL
GO

-- Drop table t1.
DROP TABLE t1

