DECLARE @myVariable AS varchar
DECLARE @myNextVariable AS char
SET @myVariable = 'abc'
SET @myNextVariable = 'abc'
--The following returns 1
SELECT DATALENGTH(@myVariable), DATALENGTH(@myNextVariable);
GO
