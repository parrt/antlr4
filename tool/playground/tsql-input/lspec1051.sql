USE AdventureWorks;
GO
WITH DirectReports(Name, Title, EmployeeID, EmployeeLevel, Sort)
AS (SELECT CONVERT(varchar(255), c.FirstName + ' ' + c.LastName),
	e.Title,
	e.EmployeeID,
	1,
	CONVERT(varchar(255), c.FirstName + ' ' + c.LastName)
    FROM HumanResources.Employee AS e
    JOIN Person.Contact AS c ON e.ContactID = c.ContactID 
    WHERE e.ManagerID IS NULL
    UNION ALL
	SELECT CONVERT(varchar(255), REPLICATE ('| ' , EmployeeLevel) +
	c.FirstName + ' ' + c.LastName),
	e.Title,
	e.EmployeeID,
	EmployeeLevel + 1,
	CONVERT (varchar(255), RTRIM(Sort) + '| ' + FirstName + ' ' + 
							 LastName)
	    FROM HumanResources.Employee as e
	    JOIN Person.Contact AS c ON e.ContactID = c.ContactID
	    JOIN DirectReports AS d ON e.ManagerID = d.EmployeeID
	    )
SELECT EmployeeID, Name, Title, EmployeeLevel
FROM DirectReports 
ORDER BY Sort;
GO
