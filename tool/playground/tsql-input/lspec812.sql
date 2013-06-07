USE AdventureWorks;
GO
CREATE SYNONYM MyEmployeeTable FOR HumanResources.Employee;
GO
SELECT OBJECTPROPERTYEX ( object_id(N'MyEmployeeTable'), N'BaseType')AS [Base Type];
GO


