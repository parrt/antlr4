SELECT RADIANS(1e-307)
GO

-- First value is -45.01.
DECLARE @angle float
SET @angle = -45.01
SELECT 'The RADIANS of the angle is: ' +
   CONVERT(varchar, RADIANS(@angle))
GO
-- Next value is -181.01.
DECLARE @angle float
SET @angle = -181.01
SELECT 'The RADIANS of the angle is: ' +
   CONVERT(varchar, RADIANS(@angle))
GO
-- Next value is 0.00.
DECLARE @angle float
SET @angle = 0.00
SELECT 'The RADIANS of the angle is: ' +
   CONVERT(varchar, RADIANS(@angle))
GO
-- Next value is 0.1472738.
DECLARE @angle float
SET @angle = 0.1472738
SELECT 'The RADIANS of the angle is: ' +
    CONVERT(varchar, RADIANS(@angle))
GO
-- Last value is 197.1099392.
DECLARE @angle float
SET @angle = 197.1099392
SELECT 'The RADIANS of the angle is: ' +
   CONVERT(varchar, RADIANS(@angle))
GO

