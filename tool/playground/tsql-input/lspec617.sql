USE AdventureWorks;
GO
CREATE SCHEMA Sprockets AUTHORIZATION Krishna 
    CREATE TABLE NineProngs (source int, cost int, partnumber int)
    GRANT SELECT TO Anibal 
    DENY SELECT TO HungFu;
GO
DROP TABLE Sprockets.NineProngs;
DROP SCHEMA Sprockets;
GO

