USE AdventureWorks;
GO
DECLARE @state char(25);
SET @state = N'Oregon';
SELECT RTRIM(FirstName) + ' ' + RTRIM(LastName) AS Name, City
FROM HumanResources.vEmployee
WHERE StateProvinceName = @state;

