DECLARE @SensitiveData nvarchar(max);
SET @SensitiveData = N'Saddle Price Points are 
    2, 3, 5, 7, 11, 13, 17, 19, 23, 29';
INSERT INTO [SignedData04]
    VALUES( N'data signed by certificate ''ABerglundCert07''',
	    @SensitiveData, SignByCert( Cert_Id( 'ABerglundCert07' ), 
		    @SensitiveData, N'pGFD4bb925DGvbd2439587y' ));
GO

