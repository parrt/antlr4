USE AdventureWorks;
GO
PRINT 'Valid query';
GO
-- SET NOEXEC to ON.
SET NOEXEC ON;
GO
-- Inner join.
SELECT e.EmployeeID, e.Title, v.Name
FROM HumanResources.Employee e 
   INNER JOIN Purchasing.PurchaseOrderHeader poh
   ON e.EmployeeID = poh.EmployeeID
   INNER JOIN Purchasing.Vendor v
   ON poh.VendorID = v.VendorID;
GO
-- SET NOEXEC to OFF.
SET NOEXEC OFF;
GO

PRINT 'Invalid object name';
GO
-- SET NOEXEC to ON.
SET NOEXEC ON;
GO
-- Function name used is a reserved keyword.
USE AdventureWorks;
GO
CREATE FUNCTION dbo.Values(@EmployeeID INT)
RETURNS TABLE
AS
RETURN (SELECT PurchaseOrderID, TotalDue
	   FROM dbo.PurchaseOrderHeader
	   WHERE EmployeeID = @EmployeeID)
-- SET NOEXEC to OFF.
SET NOEXEC OFF
GO

PRINT 'Invalid syntax';
GO
-- SET NOEXEC to ON.
SET NOEXEC ON;
GO
-- Built-in function incorrectly invoked
SELECT *
FROM fn_helpcollations;
-- Reset SET NOEXEC to OFF.
SET NOEXEC OFF;
GO

