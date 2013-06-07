USE AdventureWorks;
GO
SELECT * INTO temp_trc
FROM fn_trace_gettable('c:\temp\my_trace.trc', default);
GO
USE AdventureWorks;
GO
SELECT IDENTITY(int, 1, 1) AS RowNumber, * INTO temp_trc
FROM fn_trace_gettable('c:\temp\my_trace.trc', default);
GO

