USE AdventureWorks;
GO
IF OBJECT_ID(N'Purchasing.usp_ChangePurchaseOrderHeader',N'P')
             IS NOT NULL
   DROP PROCEDURE Purchasing.usp_ChangePurchaseOrderHeader;
GO
CREATE PROCEDURE Purchasing.usp_ChangePurchaseOrderHeader
    @PurchaseOrderID INT, 
    @EmployeeID INT
AS
-- Declare variables used in error checking.
DECLARE @ErrorVar INT, 
    @RowCountVar INT;

-- Execute the UPDATE statement.
UPDATE PurchaseOrderHeader 
    SET EmployeeID = @EmployeeID 
    WHERE PurchaseOrderID = @PurchaseOrderID;

-- Save the @@ERROR and @@ROWCOUNT values in local 
-- variables before they are cleared.
SELECT @ErrorVar = @@ERROR, 
    @RowCountVar = @@ROWCOUNT;

-- Check for errors. If an invalid @EmployeeID was specified
-- the UPDATE statement returns a foreign-key violation error #547.
IF @ErrorVar <> 0
    BEGIN
        IF @ErrorVar = 547
            BEGIN
                PRINT N'ERROR: Invalid ID specified for new employee.';
                RETURN 1;
            END
        ELSE
            BEGIN
                PRINT N'ERROR: error '
                    + RTRIM(CAST(@ErrorVar AS NVARCHAR(10)))
                    + N' occurred.';
                RETURN 2;
            END
    END

-- Check the row count. @RowCountVar is set to 0 
-- if an invalid @PurchaseOrderID was specified.
IF @RowCountVar = 0
    BEGIN
        PRINT 'Warning: The EmployeeID specified is not valid';
        RETURN 1;
    END
ELSE
    BEGIN
        PRINT 'Purchase order updated with the new employee';
        RETURN 0;
    END;
GO
