SELECT a.*
FROM OPENROWSET('SQLNCLI', 'Server=Seattle1;Trusted_Connection=yes;',
	     'SELECT GroupName, Name, DepartmentID
	      FROM AdventureWorks.HumanResources.Department
	      ORDER BY GroupName, Name') AS a;

