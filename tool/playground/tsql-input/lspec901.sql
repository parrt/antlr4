DECLARE @string_to_trim varchar(60)
SET @string_to_trim = 'Four spaces are after the period in this sentence.    '
SELECT 'Here is the string without the trailing spaces: ' + CHAR(13) +
   RTRIM(@string_to_trim)
GO

