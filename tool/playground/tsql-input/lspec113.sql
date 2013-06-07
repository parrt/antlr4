USE AdventureWorks;
GO
IF OBJECT_ID ( 'usp_FindName', 'P' ) IS NOT NULL 
DROP PROCEDURE usp_FindName;
GO
CREATE PROCEDURE usp_FindName
    @lastname varchar(40) = '%', 
    @firstname varchar(20) = '%'
AS
DECLARE @Count int;
DECLARE @ProcName nvarchar(128);
SELECT LastName, FirstName, Phone, EmailAddress
FROM Person.Contact 
WHERE FirstName LIKE @firstname AND LastName LIKE @lastname;
SET @Count = @@ROWCOUNT;
SET @ProcName = OBJECT_NAME(@@PROCID);
RAISERROR ('Stored procedure %s returned %d rows.', 16,10, @ProcName, @Count);
GO
EXECUTE dbo.usp_FindName 'P%', 'A%';
