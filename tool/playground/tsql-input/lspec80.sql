USE AdventureWorks;
GO
/*
This section of the code joins the 
Contact table with the Address table, by using the Employee table in the middle 
to get a list of all the employees in the AdventureWorks database and their 
contact information.
*/
SELECT c.FirstName, c.LastName, a.AddressLine1, a.AddressLine2, a.City
FROM Person.Contact c 
JOIN HumanResources.Employee e ON c.ContactID = e.ContactID 
JOIN HumanResources.EmployeeAddress ea ON e.EmployeeID = ea.EmployeeID
JOIN Person.Address a ON ea.AddressID = a.AddressID;
GO
