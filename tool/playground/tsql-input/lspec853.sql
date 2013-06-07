RAISERROR (N'This is message %s %d.', -- Message text.
	   10, -- Severity,
	   1, -- State,
	   N'number', -- First argument.
	   5); -- Second argument.
-- The message text returned is: This is message number 5.
GO
RAISERROR (N'<<%*.*s>>', -- Message text.
	   10, -- Severity,
	   1, -- State,
	   7, -- First argument used for width.
	   3, -- Second argument used for precision.
	   N'abcde'); -- Third argument supplies the string.
-- The message text returned is: <<    abc>>.
GO
RAISERROR (N'<<%7.3s>>', -- Message text.
	   10, -- Severity,
	   1, -- State,
	   N'abcde'); -- First argument supplies the string.
-- The message text returned is: <<    abc>>.
GO
BEGIN TRY
    -- RAISERROR with severity 11-19 will cause execution to 
    -- jump to the CATCH block.
    RAISERROR ('Error raised in TRY block.', -- Message text.
	               16, -- Severity.
		       1 -- State.
	       );
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
	@ErrorMessage = ERROR_MESSAGE(),
	@ErrorSeverity = ERROR_SEVERITY(),
	@ErrorState = ERROR_STATE();

    -- Use RAISERROR inside the CATCH block to return error
    -- information about the original error that caused
    -- execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
	               @ErrorSeverity, -- Severity.
		       @ErrorState -- State.
	       );
END CATCH;
