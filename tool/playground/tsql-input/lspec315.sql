CREATE CERTIFICATE Marketing19 WITH 
    START_DATE = '04/04/2004' ,
    EXPIRY_DATE = '07/07/2007' ,
    SUBJECT = 'Marketing Print Division';
GO

-- Now use CertProperty to examine certificate
-- Marketing19's properties.
DECLARE @CertSubject sql_variant;
set @CertSubject = CertProperty( Cert_ID('Marketing19'), 'Subject');
PRINT CONVERT(nvarchar, @CertSubject);
GO
