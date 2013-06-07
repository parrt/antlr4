DECLARE @myval decimal (5, 2)
SET @myval = 193.57
SELECT CAST(CAST(@myval AS varbinary(20)) AS decimal(10,5))
-- Or, using CONVERT
SELECT CONVERT(decimal(10,5), CONVERT(varbinary(20), @myval))
