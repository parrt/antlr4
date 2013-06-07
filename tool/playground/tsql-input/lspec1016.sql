USE AdventureWorks;
GO
DECLARE @MyTableVar table(
	    EmpID int NOT NULL,
	    OldVacationHours int,
	    NewVacationHours int,
	    ModifiedDate datetime);
UPDATE TOP (10) HumanResources.Employee
SET VacationHours = VacationHours * 1.25 
OUTPUT INSERTED.EmployeeID,
       DELETED.VacationHours,
       INSERTED.VacationHours,
       INSERTED.ModifiedDate
INTO @MyTableVar;
--Display the result set of the table variable.
SELECT EmpID, OldVacationHours, NewVacationHours, ModifiedDate
FROM @MyTableVar;
GO
--Display the result set of the table.
--Note that ModifiedDate reflects the value generated by an
--AFTER UPDATE trigger.
SELECT TOP (10) EmployeeID, VacationHours, ModifiedDate
FROM HumanResources.Employee;
GO
