DECLARE @SamplesPath nvarchar(1024);
-- You may have to modify the value of the this variable if you have
--installed the sample someplace other than the default location.
SELECT @SamplesPath = REPLACE(physical_name, 'Microsoft SQL Server\MSSQL.1\MSSQL\DATA\master.mdf', 'Microsoft SQL Server\90\Samples\Engine\Programmability\CLR\') 
    FROM master.sys.database_files 
    WHERE name = 'master';

CREATE ASSEMBLY [SurrogateStringFunction]
FROM @SamplesPath + 'StringManipulate\CS\StringManipulate\bin\debug\SurrogateStringFunction.dll'
WITH PERMISSION_SET = EXTERNAL_ACCESS;
GO

CREATE FUNCTION [dbo].[len_s] (@str nvarchar(4000))
RETURNS bigint
AS EXTERNAL NAME [SurrogateStringFunction].[Microsoft.Samples.SqlServer.SurrogateStringFunction].[LenS];
GO
