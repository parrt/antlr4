USE AdventureWorks;
GO

CREATE TABLE T1 (
	   a INT, 
	   b INT NULL, 
	   c VARCHAR(20)
);
GO

SET NOCOUNT ON

INSERT INTO T1 
VALUES (1, NULL, '');
INSERT INTO T1 
VALUES (1, 0, '');
INSERT INTO T1 
VALUES (2, 1, '');
INSERT INTO T1 
VALUES (2, 2, '');

SET NOCOUNT OFF;
GO
  
PRINT '**** Setting ANSI_WARNINGS ON';
GO
  
SET ANSI_WARNINGS ON;
GO
  
PRINT 'Testing NULL in aggregate';
GO
SELECT a, SUM(b) 
FROM T1 
GROUP BY a;
GO
  
PRINT 'Testing String Overflow in INSERT';
GO
INSERT INTO T1 
VALUES (3, 3, 'Text string longer than 20 characters');
GO
  
PRINT 'Testing Divide by zero';
GO
SELECT a / b AS ab 
FROM T1;
GO
  
PRINT '**** Setting ANSI_WARNINGS OFF';
GO
SET ANSI_WARNINGS OFF;
GO
  
PRINT 'Testing NULL in aggregate';
GO
SELECT a, SUM(b) 
FROM T1 
GROUP BY a;
GO
  
PRINT 'Testing String Overflow in INSERT';
GO
INSERT INTO T1 
VALUES (4, 4, 'Text string longer than 20 characters');
GO
SELECT a, b, c 
FROM T1
WHERE a = 4;
GO

PRINT 'Testing Divide by zero';
GO
SELECT a / b AS ab 
FROM T1;
GO

DROP TABLE T1

