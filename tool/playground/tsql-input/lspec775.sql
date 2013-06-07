USE AdventureWorks;
GO
CREATE PROCEDURE FindEmployee @EmpLName varchar(20)
AS
SELECT @EmpLName = RTRIM(@EmpLName) + '%';
SELECT c.FirstName, c.LastName, a.City
FROM Person.Contact c JOIN Person.Address a ON c.ContactID = a.AddressID
WHERE c.LastName LIKE @EmpLName;
GO
EXEC FindEmployee @EmpLName = 'Barb';

