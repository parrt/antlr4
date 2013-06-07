USE AdventureWorks;
GO
SET NOCOUNT ON;
GO
SET IMPLICIT_TRANSACTIONS OFF;
GO
PRINT N'Tran count at start = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
GO
IF OBJECT_ID(N'dbo.t1',N'U') IS NOT NULL
	    DROP TABLE dbo.t1;
	GO
	CREATE table dbo.t1 (a int);
	GO
	INSERT INTO dbo.t1 VALUES (1);
	GO
	PRINT N'Use explicit transaction.';
	BEGIN TRANSACTION;
		GO
		INSERT INTO dbo.t1 VALUES (2);
		GO
		PRINT N'Tran count in explicit transaction = '
		    + CAST(@@TRANCOUNT AS NVARCHAR(10));
		COMMIT TRANSACTION;
		GO
		PRINT N'Tran count after explicit transaction = '
		    + CAST(@@TRANCOUNT AS NVARCHAR(10));
		GO

		PRINT N'Setting IMPLICIT_TRANSACTIONS ON.';
		GO
		SET IMPLICIT_TRANSACTIONS ON;
		GO

		PRINT N'Use implicit transactions.';
		GO
		-- No BEGIN TRAN needed here.
INSERT INTO dbo.t1 VALUES (4);
GO
PRINT N'Tran count in implicit transaction = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
COMMIT TRANSACTION;
PRINT N'Tran count after implicit transaction = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));
GO

PRINT N'Nest an explicit transaction with IMPLICIT_TRANSACTIONS ON.';
GO
PRINT N'Tran count before nested explicit transaction = '
    + CAST(@@TRANCOUNT AS NVARCHAR(10));

BEGIN TRANSACTION;
	PRINT N'Tran count after nested BEGIN TRAN in implicit transaction = '
	    + CAST(@@TRANCOUNT AS NVARCHAR(10));
	INSERT INTO dbo.t1 VALUES (5);
	COMMIT TRANSACTION;
	PRINT N'Tran count after nested explicit transaction = '
	    + CAST(@@TRANCOUNT AS NVARCHAR(10));
	GO
	-- Commit outstanding tran.
COMMIT TRANSACTION;
GO

