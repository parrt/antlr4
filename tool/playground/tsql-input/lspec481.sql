USE AdventureWorks;
CREATE SCHEMA Sprockets AUTHORIZATION Annik
    CREATE TABLE NineProngs (source int, cost int, partnumber int)
    GRANT SELECT TO Mandar
    DENY SELECT TO Prasanna;
GO 
