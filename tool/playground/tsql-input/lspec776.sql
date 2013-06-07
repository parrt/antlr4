DECLARE @var float
SET @var = 10
SELECT 'The LOG of the variable is: ' + CONVERT(varchar, LOG(@var))
GO
SELECT LOG (EXP (10))


