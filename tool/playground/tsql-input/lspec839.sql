USE AdventureWorks;
GO
SELECT c.FirstName, c.LastName
    ,ROW_NUMBER() OVER(ORDER BY SalesYTD DESC) AS 'Row Number'
    ,s.SalesYTD, a.PostalCode
FROM Sales.SalesPerson s 
    INNER JOIN Person.Contact c 
        ON s.SalesPersonID = c.ContactID
	    INNER JOIN Person.Address a 
	        ON a.AddressID = c.ContactID
		WHERE TerritoryID IS NOT NULL 
		    AND SalesYTD <> 0;
		GO

