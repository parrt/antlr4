CREATE TABLE Cities (
	     Name varchar(20),
	     State varchar(20),
	     Location point );
GO
DECLARE @p point (32, 23), @distance float
GO
SELECT Location.Distance (@p)
FROM Cities;

