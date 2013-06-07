CREATE PROC usp_NestLevelValues AS
    SELECT @@NESTLEVEL AS 'Current Nest Level';
EXEC ('SELECT @@NESTLEVEL AS OneGreater'); 
EXEC sp_executesql N'SELECT @@NESTLEVEL as TwoGreater' ;
GO
EXEC usp_NestLevelValues;
GO
