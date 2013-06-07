SET NOCOUNT OFF;
DECLARE @angle float;
SET @angle = -1.0;
SELECT 'The ACOS of the angle is: ' + CONVERT(varchar, ACOS(@angle));
