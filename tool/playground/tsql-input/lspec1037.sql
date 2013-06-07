SELECT Data, VerifySignedByCert( Cert_Id( 'Shipping04' ),
	    Signed_Data, DataSignature ) AS IsSignatureValid
FROM [AdventureWorks].[SignedData04] 
WHERE Description = N'data signed by certificate ''Shipping04''';
GO
