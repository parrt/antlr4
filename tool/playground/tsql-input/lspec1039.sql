SELECT Data,
     VerifySignedByAsymKey( AsymKey_Id( 'WillisKey74' ), SignedData,
	     DataSignature ) as IsSignatureValid
FROM [AdventureWorks].[SignedData04] 
WHERE Description = N'data encrypted by asymmetric key ''WillisKey74'''
GO
RETURN
