USE AdventureWorks;
GO

-- Verify that the stored procedure does not already exist.
IF OBJECT_ID ( 'usp_ExampleProc', 'P' ) IS NOT NULL 
	    DROP PROCEDURE usp_ExampleProc;
GO

	-- Create a stored procedure that 
-- generates a divide-by-zero error.
CREATE PROCEDURE usp_ExampleProc
AS
    SELECT 1/0;
GO

BEGIN TRY
	    -- Execute the stored procedure inside the TRY block.
    EXECUTE usp_ExampleProc;
END TRY
BEGIN CATCH
	    SELECT ERROR_PROCEDURE() AS ErrorProcedure;
END CATCH;
GO


USE AdventureWorks;
GO

-- Verify that the stored procedure does not already exist.
IF OBJECT_ID ( 'usp_ExampleProc', 'P' ) IS NOT NULL 
	    DROP PROCEDURE usp_ExampleProc;
GO

	-- Create a stored procedure that 
-- generates a divide-by-zero error.
CREATE PROCEDURE usp_ExampleProc
AS
    SELECT 1/0;
GO

BEGIN TRY
	    -- Execute the stored procedure inside the TRY block.
    EXECUTE usp_ExampleProc;
END TRY
BEGIN CATCH
	    SELECT 
	        ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_MESSAGE() AS ErrorMessage,
		ERROR_LINE() AS ErrorLine;
END CATCH;
GO

