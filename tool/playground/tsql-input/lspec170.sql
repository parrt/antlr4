ALTER ENDPOINT sql_endpoint
FOR SOAP
(
  ADD WEBMETHOD 'SayHello' (name='AdventureWorks.dbo.SayHello')
);
