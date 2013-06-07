DECLARE @x float
DECLARE @y float
SET @x = 35.175643
SET @y = 129.44
SELECT 'The ATN2 of the angle is: ' + CONVERT(varchar,ATN2(@x,@y ))
GO
