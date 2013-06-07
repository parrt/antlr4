USE AdventureWorks
GO
SELECT FirstName, LastName, Shift 
FROM HumanResources.vEmployeeDepartmentHistory
WHERE Department = 'Quality Assurance'
   AND (Shift = 'Evening' OR Shift = 'Night')

