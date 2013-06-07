USE AdventureWorks;
GO

-- Create a column in which to store the encrypted data.
ALTER TABLE HumanResources.Employee
    ADD EncryptedNationalIDNumber varbinary(128); 
GO

-- Open the symmetric key with which to encrypt the data.
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE HumanResources037;

-- Encrypt the value in column NationalIDNumber with symmetric key
-- SSN_Key_01. Save the result in column EncryptedNationalIDNumber.
UPDATE HumanResources.Employee
SET EncryptedNationalIDNumber
    = EncryptByKey(Key_GUID('SSN_Key_01'), NationalIDNumber);
GO


USE AdventureWorks;

-- Create a column in which to store the encrypted data.
ALTER TABLE Sales.CreditCard
    ADD CardNumber_Encrypted varbinary(128); 
GO

-- Open the symmetric key with which to encrypt the data.
OPEN SYMMETRIC KEY CreditCards_Key11
    DECRYPTION BY CERTIFICATE Sales09;

-- Encrypt the value in column CardNumber with symmetric 
-- key CreditCards_Key11.
-- Save the result in column CardNumber_Encrypted.  
UPDATE Sales.CreditCard
SET CardNumber_Encrypted = EncryptByKey(Key_GUID('CreditCards_Key11'), 
	    CardNumber, 1, CONVERT( varbinary, CreditCardID) );
GO

