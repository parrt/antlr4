USE AdventureWorks;
CREATE ASSEMBLY Shipping19 
    FROM ' c:\Shipping\Certs\Shipping19.dll' 
    WITH PERMISSION_SET = SAFE;
GO
CREATE CERTIFICATE Shipping19 FROM ASSEMBLY Shipping19;
GO
