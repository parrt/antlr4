SELECT CustomerID, CompanyName
   FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0',
	      'C:\Program Files\Microsoft Office\OFFICE11\SAMPLES\Northwind.mdb';
	      'admin';'',Customers)
GO

