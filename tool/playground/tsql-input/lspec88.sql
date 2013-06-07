SELECT @@CPU_BUSY * CAST(@@TIMETICKS AS FLOAT) AS 'CPU microseconds', 
   GETDATE() AS 'As of' ;
