SET TEXTSIZE 0
SET NOCOUNT ON
-- Create the variables for the current character string position 
-- and for the character string.
DECLARE @position int, @string char(15)
-- Initialize the variables.
SET @position = 1
SET @string = 'Du monde entier'
WHILE @position <= DATALENGTH(@string)
   BEGIN
   SELECT ASCII(SUBSTRING(@string, @position, 1)),
      CHAR(ASCII(SUBSTRING(@string, @position, 1)))
    SET @position = @position + 1
   END
SET NOCOUNT OFF
GO
