INSERT INTO [AdventureWorks].[Sales].[ProtectedData04] 
    values( N'data encrypted by asymmetric key ''JanainaAsymKey02''',
	    EncryptByAsymKey(AsymKey_ID('JanainaAsymKey02'), @cleartext) )
GO
INSERT INTO [AdventureWorks].[ProtectedData04] 
    values( N'data encrypted by certificate ''Shipping04''',
	    EncryptByCert(Cert_ID('JanainaCert02'), @cleartext) );
GO

