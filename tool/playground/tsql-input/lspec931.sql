PRINT 'Setting ARITHIGNORE ON';
GO
-- SET ARITHIGNORE ON and testing.
SET ARITHIGNORE ON;
GO
SELECT 1 / 0 AS DivideByZero;
GO
SELECT CAST(256 AS TINYINT) AS Overflow;
GO

PRINT 'Setting ARITHIGNORE OFF';
GO
-- SET ARITHIGNORE OFF and testing.
SET ARITHIGNORE OFF;
GO
SELECT 1 / 0 AS DivideByZero;
GO
SELECT CAST(256 AS TINYINT) AS Overflow;
GO

