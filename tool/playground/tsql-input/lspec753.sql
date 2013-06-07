USE AdventureWorks;
GO
IF OBJECT_ID ('dbo.EmployeeSales', 'U') IS NOT NULL
	    DROP TABLE dbo.EmployeeSales;
	GO
	IF OBJECT_ID ('dbo.uspGetEmployeeSales', 'P') IS NOT NULL
		    DROP PROCEDURE uspGetEmployeeSales;
		GO
		CREATE TABLE dbo.EmployeeSales
		( DataSource   varchar(20) NOT NULL,
			  EmployeeID   varchar(11) NOT NULL,
			  LastName     varchar(40) NOT NULL,
			  SalesDollars money NOT NULL
		);
		GO
		CREATE PROCEDURE dbo.uspGetEmployeeSales 
		AS 
		    SELECT 'PROCEDURE', e.EmployeeID, c.LastName, 
		        sp.SalesYTD 
			    FROM HumanResources.Employee AS e 
			        INNER JOIN Sales.SalesPerson AS sp  
				        ON e.EmployeeID = sp.SalesPersonID 
					        INNER JOIN Person.Contact AS c
						        ON e.ContactID = c.ContactID
							    WHERE e.EmployeeID LIKE '2%'
							    ORDER BY e.EmployeeID, c.LastName;
							GO
							--INSERT...SELECT example
INSERT dbo.EmployeeSales
    SELECT 'SELECT', e.EmployeeID, c.LastName, sp.SalesYTD 
    FROM HumanResources.Employee AS e
        INNER JOIN Sales.SalesPerson AS sp
	        ON e.EmployeeID = sp.SalesPersonID 
		        INNER JOIN Person.Contact AS c
			        ON e.ContactID = c.ContactID
				    WHERE e.EmployeeID LIKE '2%'
				    ORDER BY e.EmployeeID, c.LastName;
				GO
				--INSERT...EXECUTE procedure example
INSERT EmployeeSales 
EXECUTE uspGetEmployeeSales;
GO
--INSERT...EXECUTE('string') example
INSERT EmployeeSales 
EXECUTE 
('
	SELECT ''EXEC STRING'', e.EmployeeID, c.LastName, 
	    sp.SalesYTD 
	    FROM HumanResources.Employee AS e 
	        INNER JOIN Sales.SalesPerson AS sp 
		        ON e.EmployeeID = sp.SalesPersonID 
			        INNER JOIN Person.Contact AS c
				        ON e.ContactID = c.ContactID
					    WHERE e.EmployeeID LIKE ''2%''
					    ORDER BY e.EmployeeID, c.LastName
					');
				GO
				--Show results.
SELECT DataSource,EmployeeID,LastName,SalesDollars
FROM dbo.EmployeeSales;
GO


