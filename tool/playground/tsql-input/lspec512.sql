CREATE LOGIN WanidaBenshoof 
    WITH PASSWORD = '8fdKJl3$nlNv3049jsKK';
USE AdventureWorks;
CREATE USER Wanida FOR LOGIN WanidaBenshoof 
    WITH DEFAULT_SCHEMA = Marketing;
GO
