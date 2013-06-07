USE AdventureWorks;
GO
-- Make sure FORCEPLAN is set to OFF.
SET SHOWPLAN_TEXT OFF;
GO
SET FORCEPLAN OFF;
GO
SET SHOWPLAN_TEXT ON;
GO
-- Example where the query plan is not forced.
SELECT c.LastName, c.FirstName, v.Name
FROM Person.Contact AS c
   INNER JOIN HumanResources.Employee AS e
   ON e.ContactID = c.ContactID
   INNER JOIN Purchasing.PurchaseOrderHeader AS poh
   ON e.EmployeeID = poh.EmployeeID
   INNER JOIN Purchasing.Vendor AS v
   ON poh.VendorID = v.VendorID;
GO
-- SET FORCEPLAN to ON.
SET SHOWPLAN_TEXT OFF;
GO
SET FORCEPLAN ON;
GO
SET SHOWPLAN_TEXT ON;
GO
-- Reexecute inner join to see the effect of SET FORCEPLAN ON.
SELECT c.LastName, c.FirstName, v.Name
FROM Person.Contact AS c
   INNER JOIN HumanResources.Employee AS e 
   ON e.ContactID = c.ContactID
   INNER JOIN Purchasing.PurchaseOrderHeader AS poh
   ON e.EmployeeID = poh.EmployeeID
   INNER JOIN Purchasing.Vendor AS v
   ON poh.VendorID = v.VendorID;
GO
SET SHOWPLAN_TEXT OFF;
GO
SET FORCEPLAN OFF;
GO

