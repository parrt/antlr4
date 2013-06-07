USE AdventureWorks ;
GO
IF OBJECT_ID ('dbo.EmployeeSales', 'U') IS NOT NULL
	    DROP TABLE dbo.EmployeeSales;
	GO
	CREATE TABLE dbo.EmployeeSales
	( EmployeeID   int IDENTITY (1,5)NOT NULL,
		  LastName     nvarchar(20) NOT NULL,
		  FirstName    nvarchar(20) NOT NULL,
		  CurrentSales money NOT NULL,
		  ProjectedSales AS CurrentSales * 1.10 
	);
	GO
	DECLARE @MyTableVar table(
		  LastName     nvarchar(20) NOT NULL,
		  FirstName    nvarchar(20) NOT NULL,
		  CurrentSales money NOT NULL
		  );

		INSERT INTO dbo.EmployeeSales (LastName, FirstName, CurrentSales)
		  OUTPUT INSERTED.LastName, 
		         INSERTED.FirstName, 
			         INSERTED.CurrentSales
				  INTO @MyTableVar
				    SELECT c.LastName, c.FirstName, sp.SalesYTD
				    FROM HumanResources.Employee AS e
				        INNER JOIN Sales.SalesPerson AS sp
					        ON e.EmployeeID = sp.SalesPersonID 
						        INNER JOIN Person.Contact AS c
							        ON e.ContactID = c.ContactID
								    WHERE e.EmployeeID LIKE '2%'
								    ORDER BY c.LastName, c.FirstName;

								SELECT LastName, FirstName, CurrentSales
								FROM @MyTableVar;
								GO
								SELECT EmployeeID, LastName, FirstName, CurrentSales, ProjectedSales
								FROM dbo.EmployeeSales;
								GO


