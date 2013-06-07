DECLARE @string_to_trim varchar(60)
SET @string_to_trim = '     Five spaces are at the beginning of this
   string.'
SELECT 'Here is the string without the leading spaces: ' + 
   LTRIM(@string_to_trim)
GO

