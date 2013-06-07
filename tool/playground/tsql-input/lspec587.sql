SELECT convert(nvarchar(max), DecryptByCert(Cert_Id('JanainaCert02'),
		    ProtectedData, N'pGFD4bb925DGvbd2439587y'))
FROM [AdventureWorks].[ProtectedData04] 
WHERE Description 
    = N'data encrypted by certificate '' JanainaCert02''';
GO

