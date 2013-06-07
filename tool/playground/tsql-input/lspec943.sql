DECLARE @Today DATETIME
SET @Today = '12/1/2003'

SET LANGUAGE Italian
SELECT DATENAME(month, @Today) AS 'Month Name'

SET LANGUAGE us_english
SELECT DATENAME(month, @Today) AS 'Month Name' 
GO

