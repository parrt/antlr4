IF @@OPTIONS & 512 <> 0
	    PRINT N'This user has SET NOCOUNT turned ON.';
ELSE
	    PRINT N'This user has SET NOCOUNT turned OFF.';
GO
-- Build the message text by concatenating
-- strings and expressions using functionality
-- available in SQL Server 2000 and SQL Server 2005.
PRINT N'This message was printed on '
    + RTRIM(CAST(GETDATE() AS NVARCHAR(30)))
    + N'.';
GO
-- This example shows building the message text
-- in a variable and then passing it to PRINT.
-- This was required in SQL Server 7.0 or earlier.
DECLARE @PrintMessage NVARCHAR(50);
SET @PrintMessage = N'This message was printed on '
    + RTRIM(CAST(GETDATE() AS NVARCHAR(30)))
    + N'.';
PRINT @PrintMessage;
GO


