USE AdventureWorks;
RESTORE MASTER KEY 
    FROM FILE = 'c:\backups\keys\AdventureWorks_master_key' 
    DECRYPTION BY PASSWORD = '3dH85Hhk003#GHkf02597gheij04' 
    ENCRYPTION BY PASSWORD = '259087M#MyjkFkjhywiyedfgGDFD';
GO

