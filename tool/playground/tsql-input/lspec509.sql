CREATE ASSEMBLY utf8string
FROM '\\ComputerName\utf8string\utf8string.dll' ;
GO
CREATE TYPE Utf8String 
EXTERNAL NAME utf8string.[Microsoft.Samples.SqlServer.utf8string] ;
GO
