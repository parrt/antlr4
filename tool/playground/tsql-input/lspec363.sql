DECLARE @angle float
SET @angle = 124.1332
SELECT 'The COT of the angle is: ' + CONVERT(varchar,COT(@angle))
GO
