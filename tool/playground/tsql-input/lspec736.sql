--(1)
SELECT IDENTITY(int, 1,1) AS ID_Num
INTO NewTable
FROM OldTable

--(2)
SELECT ID_Num = IDENTITY(int, 1, 1)
INTO NewTable
FROM OldTable
USE AdventureWorks;
GO
IF OBJECT_ID (N'Person.NewContact', N'U') IS NOT NULL
	    DROP TABLE Person.NewContact;
GO
ALTER DATABASE AdventureWorks SET RECOVERY BULK_LOGGED;
GO
SELECT  IDENTITY(smallint, 100, 1) AS ContactNum,
		FirstName AS First,
		LastName AS Last
	INTO Person.NewContact
	FROM Person.Contact;
GO
ALTER DATABASE AdventureWorks SET RECOVERY FULL;
GO
SELECT ContactNum, First, Last FROM Person.NewContact;
GO
			
