DECLARE @var float
SET @var = 10
SELECT 'The EXP of the variable is: ' + CONVERT(varchar,EXP(@var))
GO
SELECT EXP( LOG(20)), LOG( EXP(20))
GO

