USE AdventureWorks;
GO
SELECT ContactID, FirstName, LastName, Phone
FROM Person.Contact
WHERE LastName LIKE 'G%'
ORDER BY LastName, FirstName 
FOR XML AUTO, TYPE, XMLSCHEMA, ELEMENTS XSINIL;


