USE AdventureWorks ;
GO
SELECT a.City, COUNT(ea.AddressID) EmployeeCount
FROM HumanResources.EmployeeAddress ea 
INNER JOIN Person.Address a
ON ea.AddressID = a.AddressID
GROUP BY a.City
ORDER BY a.City ;


