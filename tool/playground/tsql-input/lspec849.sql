SELECT POWER(2.0, -100.0)
GO

DECLARE @value int, @counter int
SET @value = 2
SET @counter = 1

WHILE @counter < 5
	   BEGIN
		      SELECT POWER(@value, @counter)
		      SET NOCOUNT ON
		      SET @counter = @counter + 1
		      SET NOCOUNT OFF
		   END
		GO

