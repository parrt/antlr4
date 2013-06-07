USE Northwind  
GO
SELECT c.*, o.*
FROM Northwind.dbo.Customers AS c 
   INNER JOIN OPENROWSET('Microsoft.Jet.OLEDB.4.0', 
	   'C:\Program Files\Microsoft Office\OFFICE11\SAMPLES\Northwind.mdb';'admin';'', Orders)    
   AS o 
   ON c.CustomerID = o.CustomerID 
GO

