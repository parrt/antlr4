-- Create the table to accept the results.
CREATE TABLE #tracestatus (
	   TraceFlag int,
	   Status int
	   )

	-- Execute the command, putting the results in the table.
INSERT INTO #tracestatus 
   EXEC ('DBCC TRACESTATUS (-1) WITH NO_INFOMSGS')

-- Display the results.
SELECT * 
FROM #tracestatus
GO

