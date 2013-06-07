DROP ENDPOINT sql_endpoint;
GO

CREATE ENDPOINT sql_endpoint 
STATE = STARTED
AS HTTP(
   PATH = '/sql', 
   AUTHENTICATION = (INTEGRATED ), 
   PORTS = ( CLEAR ), 
   SITE = 'SERVER'
   )
FOR SOAP (
   WEBMETHOD 'GetSqlInfo' 
            (name='master.dbo.xp_msver', 
             SCHEMA=STANDARD ),
   WEBMETHOD 'DayAsNumber' 
            (name='master.sys.fn_MSdayasnumber'),
   WSDL = DEFAULT,
   SCHEMA = STANDARD,
   DATABASE = 'master',
   NAMESPACE = 'http://tempUri.org/'
   ); 
GO
