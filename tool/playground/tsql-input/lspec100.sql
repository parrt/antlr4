SELECT @@IO_BUSY*@@TIMETICKS AS 'IO microseconds', 
   GETDATE() AS 'as of'
