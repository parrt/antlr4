SELECT tcpe.port
FROM sys.tcp_endpoints AS tcpe
INNER JOIN sys.service_broker_endpoints AS ssbe
   ON ssbe.endpoint_id = tcpe.endpoint_id
WHERE ssbe.name = N'MyServiceBrokerEndpoint';
