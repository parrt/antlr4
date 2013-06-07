DECLARE @myvalue float;
SET @myvalue = 1.00;
WHILE @myvalue < 10.00
	   BEGIN
		      SELECT SQRT(@myvalue);
		      SET @myvalue = @myvalue + 1
		   END;
		GO

