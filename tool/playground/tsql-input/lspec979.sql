SELECT SUSER_ID('sa')
SELECT SUSER_NAME(1)
SELECT SUSER_SID('sa');
GO
SELECT SUSER_SID('London\Workstation1');
GO
USE AdventureWorks;
GO
CREATE TABLE sid_example
(
	login_sid   varbinary(85) DEFAULT SUSER_SID(),
	login_name  varchar(30) DEFAULT SYSTEM_USER,
	login_dept  varchar(10) DEFAULT 'SALES',
	login_date  datetime DEFAULT GETDATE()
) 
GO
INSERT sid_example DEFAULT VALUES
GO

