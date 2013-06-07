USE AdventureWorks;
GO
CREATE PROCEDURE checkstate @param varchar(11)
AS
IF (SELECT StateProvince FROM Person.vAdditionalContactInfo WHERE ContactID = @param) = 'WA'
	    RETURN 1
ELSE
	    RETURN 2;
GO

