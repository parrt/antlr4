USE AdventureWorks ;
GO
IF OBJECT_ID ('SeattleOnly', 'V') IS NOT NULL
DROP VIEW SeattleOnly ;
GO
CREATE VIEW SeattleOnly
AS
SELECT c.LastName, c.FirstName, a.City, s.StateProvinceCode
FROM Person.Contact c JOIN HumanResources.Employee e ON c.ContactID = e.ContactID
JOIN HumanResources.EmployeeAddress ea ON e.EmployeeID = ea.EmployeeID
JOIN Person.Address a ON ea.AddressID = a.AddressID
JOIN Person.StateProvince s ON a.StateProvinceID = s.StateProvinceID
WHERE a.City = 'Seattle'
WITH CHECK OPTION ;
GO

