USE AdventureWorks ;
GO
SELECT RTRIM(c.FirstName) + ' ' + LTRIM(c.LastName) AS Name,
 d.City
FROM Person.Contact c
INNER JOIN HumanResources.Employee e ON c.ContactID = e.ContactID 
INNER JOIN
   (SELECT ea.AddressID, ea.EmployeeID, a.City 
	    FROM Person.Address a
	    INNER JOIN HumanResources.EmployeeAddress ea
	    ON a.AddressID = ea.AddressID) AS d
ON e.EmployeeID = d.EmployeeID
ORDER BY c.LastName, c.FirstName;


