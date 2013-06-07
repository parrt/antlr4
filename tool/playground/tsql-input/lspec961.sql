DECLARE @value real
SET @value = -1
WHILE @value < 2
	   BEGIN
		      SELECT SIGN(@value)
		      SET NOCOUNT ON
		      SELECT @value = @value + 1
		      SET NOCOUNT OFF
		   END
		SET NOCOUNT OFF
		GO

