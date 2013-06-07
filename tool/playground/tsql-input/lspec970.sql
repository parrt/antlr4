DECLARE @h float, @r float
SET @h = 5
SET @r = 1
SELECT PI()* SQUARE(@r)* @h AS 'Cyl Vol'

