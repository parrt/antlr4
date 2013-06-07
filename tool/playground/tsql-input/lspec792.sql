USE AdventureWorks;
GO
SELECT c.FirstName, c.LastName
    ,NTILE(4) OVER(ORDER BY SalesYTD DESC) AS 'Quartile'
    ,s.SalesYTD, a.PostalCode
FROM Sales.SalesPerson s 
    INNER JOIN Person.Contact c 
        ON s.SalesPersonID = c.ContactID
	    INNER JOIN Person.Address a 
	        ON a.AddressID = c.ContactID
		WHERE TerritoryID IS NOT NULL 
		    AND SalesYTD <> 0;
		GO

