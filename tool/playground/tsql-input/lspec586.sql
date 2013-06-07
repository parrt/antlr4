SELECT CONVERT(nvarchar(max),
	    DecryptByAsymKey( AsymKey_Id('JanainaAsymKey02'), 
		    ProtectedData, N'pGFD4bb925DGvbd2439587y' )) 
AS DecryptedData 
FROM [AdventureWorks].[Sales].[ProtectedData04] 
WHERE Description = N'encrypted by asym key''JanainaAsymKey02''';
GO

