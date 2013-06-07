USE AdventureWorks;
-- Get the pass phrase from the user.
DECLARE @PassphraseEnteredByUser nvarchar(128);
SET @PassphraseEnteredByUser 
= 'A little learning is a dangerous thing!';

-- Decrypt the encrypted record.
SELECT CardNumber, CardNumber_EncryptedbyPassphrase 
    AS 'Encrypted card number', CONVERT(nvarchar,
	    DecryptByPassphrase(@PassphraseEnteredByUser, CardNumber_EncryptedbyPassphrase, 1 
		    , CONVERT(varbinary, CreditCardID)))
    AS 'Decrypted card number' FROM Sales.CreditCard 
    WHERE CreditCardID = '3681';
GO

