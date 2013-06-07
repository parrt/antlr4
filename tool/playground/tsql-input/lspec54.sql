USE master;
GO
SET NOCOUNT ON
DECLARE @startdate datetime, @adddays int
SET @startdate = '1/10/1900 12:00 AM'
SET @adddays = 5
SET NOCOUNT OFF
SELECT @startdate + 1.25 AS 'Start Date', 
   @startdate + @adddays AS 'Add Date'

