/* The first value will be -1.01. This fails because the value is 
outside the range.*/
DECLARE @angle float
SET @angle = -1.01
SELECT 'The ASIN of the angle is: ' + CONVERT(varchar, ASIN(@angle))
GO

-- The next value is -1.00.
DECLARE @angle float
SET @angle = -1.00
SELECT 'The ASIN of the angle is: ' + CONVERT(varchar, ASIN(@angle))
GO

-- The next value is 0.1472738.
DECLARE @angle float
SET @angle = 0.1472738
SELECT 'The ASIN of the angle is: ' + CONVERT(varchar, ASIN(@angle))
GO
