DECLARE Employee_Cursor CURSOR FOR
SELECT EmployeeID, Title 
FROM AdventureWorks.HumanResources.Employee
WHERE ManagerID =3;
OPEN Employee_Cursor;
FETCH NEXT FROM Employee_Cursor;
WHILE @@FETCH_STATUS = 0
	   BEGIN
		      FETCH NEXT FROM Employee_Cursor;
		   END;
		CLOSE Employee_Cursor;
		DEALLOCATE Employee_Cursor;
		GO
