-- Choose the AdventureWorks database.
USE AdventureWorks;
GO
-- Choose all columns and all rows from the Address table.
SELECT *
FROM Person.Address
ORDER BY PostalCode ASC; -- We do not have to specify ASC because 
-- that is the default.
GO
