USE AdventureWorks;
-- First open the symmetric key that you want for decryption.
OPEN SYMMETRIC KEY HarnpadoungsatayaSE3 
    DECRYPTION BY CERTIFICATE sariyaCert01;
-- Use the key that is already open to decrypt MarketingKey11.
OPEN SYMMETRIC KEY MarketingKey11 
    DECRYPTION BY SYMMETRIC KEY HarnpadoungsatayaSE3;
GO 

