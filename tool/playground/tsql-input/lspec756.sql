USE AdventureWorks;
GO
IF OBJECT_ID (N'HumanResources.NewEmployee', N'U') IS NOT NULL
	    DROP TABLE HumanResources.NewEmployee;
	GO
	CREATE TABLE HumanResources.NewEmployee
	(
		    EmployeeID int NOT NULL,
		    LastName nvarchar(50) NOT NULL,
		    FirstName nvarchar(50) NOT NULL,
		    Phone Phone NULL,
		    AddressLine1 nvarchar(60) NOT NULL,
		    City nvarchar(30) NOT NULL,
		    State nchar(3) NOT NULL, 
		    PostalCode nvarchar(15) NOT NULL,
		    CurrentFlag Flag
	);
	GO
	WITH EmployeeTemp (EmpID, LastName, FirstName, Phone, 
		                   Address, City, StateProvince, 
				                   PostalCode, CurrentFlag)
					AS (SELECT 
						        e.EmployeeID, c.LastName, c.FirstName, c.Phone,
							        a.AddressLine1, a.City, sp.StateProvinceCode, 
								        a.PostalCode, e.CurrentFlag
									    FROM HumanResources.Employee e
									        INNER JOIN HumanResources.EmployeeAddress AS ea
										        ON e.EmployeeID = ea.EmployeeID
											        INNER JOIN Person.Address AS a
												        ON ea.AddressID = a.AddressID
													        INNER JOIN Person.StateProvince AS sp
														        ON a.StateProvinceID = sp.StateProvinceID
															        INNER JOIN Person.Contact as c
																        ON e.ContactID = c.ContactID
																	    )
																	INSERT INTO HumanResources.NewEmployee 
																	    SELECT EmpID, LastName, FirstName, Phone, 
																	           Address, City, StateProvince, PostalCode, CurrentFlag
																		    FROM EmployeeTemp;
																		GO

																		
