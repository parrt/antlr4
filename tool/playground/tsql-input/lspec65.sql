USE AdventureWorks;
GO
DECLARE @altstartdate datetime;
SET @altstartdate = CONVERT(DATETIME, '01/10/1900 3:00 AM', 101);
SELECT @altstartdate - 1.5 AS 'Subtract Date';
