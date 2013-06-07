DECLARE @SamplesPath nvarchar(1024)
SELECT @SamplesPath = REPLACE(physical_name, 
    'Microsoft SQL Server\MSSQL.1\MSSQL\DATA\master.mdf', 
    'Microsoft SQL Server\90\Samples\Engine\Programmability\CLR\') 
FROM master.sys.database_files 
WHERE name = 'master';
CREATE ASSEMBLY HelloWorld 
FROM @SamplesPath + 'HelloWorld\CS\HelloWorld\bin\debug\HelloWorld.dll'
WITH PERMISSION_SET = SAFE;
