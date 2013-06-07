USE AdventureWorks;
GO
-- Create a column in which to store the encrypted data.
ALTER TABLE Sales.CreditCard 
    ADD CardNumber_EncryptedbyPassphrase varbinary(256); 
GO
-- First get the passphrase from the user.
DECLARE @PassphraseEnteredByUser nvarchar(128);
SET @PassphraseEnteredByUser 
    = 'A little learning is a dangerous thing!';

-- Update the record for the user's credit card.
-- In this case, the record is number 3681.
UPDATE Sales.CreditCard
SET CardNumber_EncryptedbyPassphrase = EncryptByPassPhrase(@PassphraseEnteredByUser
	    , CardNumber, 1, CONVERT( varbinary, CreditCardID))
WHERE CreditCardID = '3681';
GO

