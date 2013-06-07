-- First, open the symmetric key with which to decrypt the data.
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE HumanResources037;
GO

-- Now list the original ID, the encrypted ID, and the 
-- decrypted ciphertext. If the decryption worked, the original
-- and the decrypted ID will match.
SELECT NationalIDNumber, EncryptedNationalID 
    AS 'Encrypted ID Number',
    CONVERT(nvarchar, DecryptByKey(EncryptedNationalID)) 
    AS 'Decrypted ID Number'
    FROM HumanResources.Employee;
GO


-- First, open the symmetric key with which to decrypt the data
OPEN SYMMETRIC KEY CreditCards_Key11
   DECRYPTION BY CERTIFICATE Sales09;
GO

-- Now list the original card number, the encrypted card number,
-- and the decrypted ciphertext. If the decryption worked, 
-- the original number will match the decrypted number.
SELECT CardNumber, CardNumber_Encrypted 
    AS 'Encrypted card number', CONVERT(nvarchar,
	    DecryptByKey(CardNumber_Encrypted, 1 , 
		    HashBytes('SHA1', CONVERT(varbinary, CreditCardID)))) 
    AS 'Decrypted card number' FROM Sales.CreditCard;
GO


