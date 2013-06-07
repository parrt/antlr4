USE AdventureWorks;
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'sfj5300osdVdgwdfkli7';
BACKUP MASTER KEY TO FILE = 'c:\temp\exportedmasterkey' 
    ENCRYPTION BY PASSWORD = 'sd092735kjn$&adsg';
GO 
