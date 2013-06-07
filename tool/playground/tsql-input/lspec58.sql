DECLARE @mybin1 binary(5), @mybin2 binary(5)
SET @mybin1 = 0xFF
SET @mybin2 = 0xA5
-- No CONVERT or CAST function is required because this example 
-- concatenates two binary strings.
SELECT @mybin1 + @mybin2
-- A CONVERT or CAST function is required because this example
-- concatenates two binary strings plus a space.
SELECT CONVERT(varchar(5), @mybin1) + ' ' 
   + CONVERT(varchar(5), @mybin2)
-- Here is the same conversion using CAST.
SELECT CAST(@mybin1 AS varchar(5)) + ' ' 
   + CAST(@mybin2 AS varchar(5))

