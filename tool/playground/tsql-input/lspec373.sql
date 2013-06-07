USE AdventureWorks;
CREATE CERTIFICATE Shipping11 
    FROM FILE = 'c:\Shipping\Certs\Shipping11.cer' 
    WITH PRIVATE KEY (FILE = 'c:\Shipping\Certs\Shipping11.pvk', 
    DECRYPTION BY PASSWORD = 'sldkflk34et6gs%53#v00');
GO 
