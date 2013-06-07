DECLARE @myVariable AS varchar(40)
SET @myVariable = 'This string is longer than thirty characters'
SELECT CAST(@myVariable AS varchar)
SELECT DATALENGTH(CAST(@myVariable AS varchar)) AS 'VarcharDefaultLength';
SELECT CONVERT(char, @myVariable)
SELECT DATALENGTH(CONVERT(char, @myVariable)) AS 'VarcharDefaultLength';
