-- SET DATEFIRST to U.S. English default value of 7.
SET DATEFIRST 7;

SELECT CAST('1/1/1999' AS DATETIME) AS SelectDate, DATEPART(dw, '1/1/1999') AS DayOfWeek;
-- January 1, 1999 is a Friday. Because the U.S. English default 
-- specifies Sunday as the first day of the week, DATEPART of 1/1/1999 
-- (Friday) yields a value of 6, because Friday is the sixth day of the 
-- week when starting with Sunday as day 1.

SET DATEFIRST 3;
-- Because Wednesday is now considered the first day of the week,
-- DATEPART should now show that 1/1/1999 (a Friday) is the third day of the 
-- week. The following DATEPART function should return a value of 3.
SELECT CAST('1/1/1999' AS DATETIME) AS SelectDate, DATEPART(dw, '1/1/1999') AS DayOfWeek;
GO

