SELECT Employee_ID, Department_ID FROM @MyTableVar
SELECT EmployeeID, DepartmentID 
FROM @MyTableVar m
JOIN Employee on (m.EmployeeID =Employee.EmployeeID AND
	   m.DepartmentID = Employee.DepartmentID)
 

