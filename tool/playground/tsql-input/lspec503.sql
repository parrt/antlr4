USE AdventureWorks
IF OBJECT_ID ('HumanResources.trig1','TR') IS NOT NULL
   DROP TRIGGER HumanResources.trig1
GO
-- Creating a trigger on a nonexistent table.
CREATE TRIGGER trig1
on HumanResources.Employee
AFTER INSERT, UPDATE, DELETE
AS 
   SELECT e.EmployeeID, e.BirthDate, x.info 
   FROM HumanResources.Employee e INNER JOIN does_not_exist x 
      ON e.EmployeeID = x.xID
GO
-- Here is the statement to actually see the text of the trigger.
SELECT t.object_id, m.definition
FROM sys.triggers t INNER JOIN sys.sql_modules m 
   ON t.object_id = m.object_id
WHERE t.type = 'TR' and t.name = 'trig1'
AND t.parent_class = 1
GO

-- Creating a trigger on an existing table, but with a nonexistent 
-- column.
USE AdventureWorks
IF OBJECT_ID ('HumanResources.trig2','TR') IS NOT NULL
   DROP TRIGGER HumanResources.trig2
GO
CREATE TRIGGER trig2 
ON HumanResources.Employee
AFTER INSERT, UPDATE
AS 
   DECLARE @fax varchar(12)
   SELECT @fax = 'AltPhone'
   FROM HumanResources.Employee
GO
-- Here is the statement to actually see the text of the trigger.
SELECT t.object_id, m.definition
FROM sys.triggers t INNER JOIN sys.sql_modules m 
   ON t.object_id = m.object_id
WHERE t.type = 'TR' and t.name = 'trig2'
AND t.parent_class = 1
GO

