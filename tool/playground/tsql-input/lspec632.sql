USE AdventureWorks;
GO

BEGIN TRY
	    -- Generate a divide-by-zero error.
    SELECT 1/0;
END TRY
BEGIN CATCH
	    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO


USE AdventureWorks;
GO

BEGIN TRY
	    -- Generate a divide-by-zero error.
    SELECT 1/0;
END TRY
BEGIN CATCH
	    SELECT
	        ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO
