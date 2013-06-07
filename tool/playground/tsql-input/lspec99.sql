/*
   This is of course the most uesful test of the most useful function.
*/
SELECT @@IDLE * CAST(@@TIMETICKS AS float) AS 'Idle microseconds',
   GETDATE() AS 'as of'
