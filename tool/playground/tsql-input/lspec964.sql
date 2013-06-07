DECLARE @angle float
SET @angle = 45.175643
SELECT 'The SIN of the angle is: ' + CONVERT(varchar,SIN(@angle))
GO

