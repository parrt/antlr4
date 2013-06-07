USE AdventureWorks;
GO
--Display the value of LocationID in the last row in the table.
SELECT MAX(LocationID) FROM Production.Location;
GO
INSERT INTO Production.Location (Name, CostRate, Availability, ModifiedDate)
VALUES ('Damaged Goods', 5, 2.5, GETDATE());
GO
SELECT @@IDENTITY AS 'Identity';
GO
--Display the value of LocationID of the newly inserted row.
SELECT MAX(LocationID) FROM Production.Location;
GO
