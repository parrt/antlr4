CREATE ENDPOINT endpoint_mirroring
    STATE = STARTED
    AS TCP ( LISTENER_PORT = 7022 )
    FOR DATABASE_MIRRORING (
       AUTHENTICATION = WINDOWS KERBEROS,
       ENCRYPTION = SUPPORTED,
       ROLE=ALL);
GO
