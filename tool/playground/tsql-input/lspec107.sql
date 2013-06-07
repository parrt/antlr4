USE AdventureWorks;
GO
IF OBJECT_ID (N'usp_OuterProc', N'P')IS NOT NULL
    DROP PROCEDURE usp_OuterProc;
GO
IF OBJECT_ID (N'usp_InnerProc', N'P')IS NOT NULL
    DROP PROCEDURE usp_InnerProc;
GO
CREATE PROCEDURE usp_InnerProc AS 
    SELECT @@NESTLEVEL AS 'Inner Level';
GO
CREATE PROCEDURE usp_OuterProc AS 
    SELECT @@NESTLEVEL AS 'Outer Level';
    EXEC usp_InnerProc;
GO
EXECUTE usp_OuterProc;
GO
