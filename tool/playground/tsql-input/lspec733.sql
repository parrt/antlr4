USE AdventureWorks;
GO
SELECT IDENT_CURRENT ('Person.Address') AS Current_Identity;
GO

USE AdventureWorks;
GO
IF OBJECT_ID(N't6', N'U') IS NOT NULL 
	    DROP TABLE t6;
	GO
	IF OBJECT_ID(N't7', N'U') IS NOT NULL 
		    DROP TABLE t7;
		GO
		CREATE TABLE t6(id int IDENTITY);
		CREATE TABLE t7(id int IDENTITY(100,1));
		GO
		CREATE TRIGGER t6ins ON t6 FOR INSERT 
		AS
		BEGIN
			   INSERT t7 DEFAULT VALUES
		END;
		GO
		--End of trigger definition

SELECT id FROM t6;
--id is empty.

SELECT id FROM t7;
--ID is empty.

--Do the following in Session 1
INSERT t6 DEFAULT VALUES;
SELECT @@IDENTITY;
/*Returns the value 100. This was inserted by the trigger.*/

SELECT SCOPE_IDENTITY();
/* Returns the value 1. This was inserted by the 
INSERT statement two statements before this query.*/

SELECT IDENT_CURRENT('t7');
/* Returns value inserted into t7, that is in the trigger.*/

SELECT IDENT_CURRENT('t6');
/* Returns value inserted into t6. This was the INSERT statement four statements before this query.*/

-- Do the following in Session 2.
SELECT @@IDENTITY;
/* Returns NULL because there has been no INSERT action 
up to this point in this session.*/

SELECT SCOPE_IDENTITY();
/* Returns NULL because there has been no INSERT action 
up to this point in this scope in this session.*/

SELECT IDENT_CURRENT('t7');
/* Returns the last value inserted into t7.*/

