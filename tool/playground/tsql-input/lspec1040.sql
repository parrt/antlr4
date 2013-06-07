SELECT Data 
FROM [AdventureWorks].[SignedData04] 
WHERE VerifySignedByAsymKey( AsymKey_Id( 'WillisKey74' ), Data,
	     DataSignature ) = 1
AND Description = N'data encrypted by asymmetric key ''WillisKey74'''
GO
