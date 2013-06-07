SELECT SUSER_SNAME(0x01);
GO
SELECT SUSER_SNAME(0x010500000000000515000000a065cf7e784b9b5fe77c87705a2e0000);
GO
USE AdventureWorks;
GO
CREATE TABLE sname_example
(
	login_sname sysname DEFAULT SUSER_SNAME(),
	employee_id uniqueidentifier DEFAULT NEWID(),
	login_date  datetime DEFAULT GETDATE()
) 
GO
INSERT sname_example DEFAULT VALUES
GO
SELECT SUSER_SNAME(); 

GO 

EXECUTE AS LOGIN = 'WanidaBenShoof'; 

SELECT SUSER_SNAME(); 

REVERT; 

GO 

SELECT SUSER_SNAME(); 

GO 

