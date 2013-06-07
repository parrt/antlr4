SELECT Data FROM [AdventureWorks].[SignedData04] 
WHERE VerifySignedByCert( Cert_Id( 'Shipping04' ), Data, 
	    DataSignature ) = 1 
AND Description = N'data signed by certificate ''Shipping04''';
GO
