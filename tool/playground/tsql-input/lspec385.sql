USE master;
GO
--Detach the AdventureWorks database
sp_detach_db AdventureWorks;
GO
-- Physically move the full text catalog to the new location.
--Attach the AdventureWorks database and specify the new location of the full-text catalog.
CREATE DATABASE AdventureWorks ON 
    (FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\AdventureWorks_Data.mdf'), 
    (FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\AdventureWorks_log.ldf'),
    (FILENAME = 'c:\myFTCatalogs\AdvWksFtCat')
FOR ATTACH;
GO
