USE AdventureWorks;
GO
CREATE TABLE employees
(
	 emp_id char(11) NOT NULL,
	 emp_lname varchar(40) NOT NULL,
	 emp_fname varchar(20) NOT NULL,
	 emp_hire_date datetime DEFAULT GETDATE(),
	 emp_mgr varchar(30)
);
GO

