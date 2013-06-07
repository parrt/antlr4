DECLARE @return_status int;
EXEC @return_status = checkstate '2';
SELECT 'Return Status' = @return_status;
GO

DECLARE @return_status int;
EXEC @return_status = checkstate '6';
SELECT 'Return Status' = @return_status;
GO

DECLARE @return_status int
EXEC @return_status = checkstate '12345678901';
SELECT 'Return Status' = @return_status;
GO

