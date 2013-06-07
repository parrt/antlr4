USE AdventureWorks;
GO
SELECT FirstName + ' ' + LastName, + CHAR(13)  + EmailAddress + CHAR(13) 
+ Phone
FROM Person.Contact

WHERE ContactID = 1;
GO
