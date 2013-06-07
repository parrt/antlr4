SELECT RAND(100), RAND(), RAND() 
DECLARE @counter smallint
SET @counter = 1
WHILE @counter < 5
BEGIN
      SELECT RAND() Random_Number
      SET @counter = @counter + 1
END
GO

