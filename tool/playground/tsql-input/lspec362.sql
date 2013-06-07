DECLARE @angle float
SET @angle = 14.78
SELECT 'The COS of the angle is: ' + CONVERT(varchar,COS(@angle))
GO
