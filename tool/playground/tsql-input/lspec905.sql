USE tempdb
GO
CREATE TABLE TZ (
	   Z_id  int IDENTITY(1,1)PRIMARY KEY,
	   Z_name varchar(20) NOT NULL)

INSERT TZ
   VALUES ('Lisa')
INSERT TZ
   VALUES ('Mike')
INSERT TZ
   VALUES ('Carla')

SELECT * FROM TZ
CREATE TABLE TY (
	   Y_id  int IDENTITY(100,5)PRIMARY KEY,
	   Y_name varchar(20) NULL)

INSERT TY (Y_name)
   VALUES ('boathouse')
INSERT TY (Y_name)
   VALUES ('rocks')
INSERT TY (Y_name)
   VALUES ('elevator')

SELECT * FROM TY
/*Create the trigger that inserts a row in table TY 
when a row is inserted in table TZ*/
CREATE TRIGGER Ztrig
ON TZ
FOR INSERT AS 
   BEGIN
	   INSERT TY VALUES ('')
	   END

	/*FIRE the trigger and determine what identity values you obtain 
with the @@IDENTITY and SCOPE_IDENTITY functions.*/
INSERT TZ VALUES ('Rosalie')

SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY]
GO
SELECT   @@IDENTITY AS [@@IDENTITY]
GO

