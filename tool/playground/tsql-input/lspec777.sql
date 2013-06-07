DECLARE @var float
SET @var = 145.175643
SELECT 'The LOG10 of the variable is: ' + CONVERT(varchar,LOG10(@var))
GO
SELECT POWER (10, LOG10(5))
