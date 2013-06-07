USE AdventureWorks
IF OBJECT_ID ('dbo.new_employees', 'U') IS NOT NULL
	   DROP TABLE new_employees
	GO
	CREATE TABLE new_employees
	(
		 id_num int IDENTITY(1,1),
		 fname varchar (20),
		 minit char(1),
		 lname varchar(30)
	)

	INSERT new_employees
	   (fname, minit, lname)
	VALUES
	   ('Karin', 'F', 'Josephs')

	INSERT new_employees
	   (fname, minit, lname)
	VALUES
	   ('Pirkko', 'O', 'Koskitalo')

