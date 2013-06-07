-- Creating a table using NEWID for uniqueidentifier data type.
CREATE TABLE cust
(
	 CustomerID uniqueidentifier NOT NULL
	   DEFAULT newid(),
	 Company varchar(30) NOT NULL,
	 ContactName varchar(60) NOT NULL, 
	 Address varchar(30) NOT NULL, 
	 City varchar(30) NOT NULL,
	 StateProvince varchar(10) NULL,
	 PostalCode varchar(10) NOT NULL, 
	 CountryRegion varchar(20) NOT NULL, 
	 Telephone varchar(15) NOT NULL,
	 Fax varchar(15) NULL
)
GO
-- Inserting data into cust table.
INSERT cust
(CustomerID, Company, ContactName, Address, City, StateProvince, 
	 PostalCode, CountryRegion, Telephone, Fax)
VALUES
(NEWID(), 'Wartian Herkku', 'Pirkko Koskitalo', 'Torikatu 38', 'Oulu', NULL,
	 '90110', 'Finland', '981-443655', '981-443655')
INSERT cust
(CustomerID, Company, ContactName, Address, City, StateProvince,
	PostalCode, CountryRegion, Telephone, Fax)
VALUES 
(NEWID(), 'Wellington Importadora', 'Paula Parente', 'Rua do Mercado, 12', 'Resende', 'SP',
	 '08737-363', 'Brasil', '(14) 555-8122', '')
INSERT cust
(CustomerID, Company, ContactName, Address, City, StateProvince,
	 PostalCode, CountryRegion, Telephone, Fax)
VALUES
(NEWID(), 'Cactus Comidas para Ilevar', 'Patricio Simpson', 'Cerrito 333', 'Buenos Aires', NULL, 
	 '1010', 'Argentina', '(1) 135-5555', '(1) 135-4892')
INSERT cust
(CustomerID, Company, ContactName, Address, City, StateProvince,
	 PostalCode, CountryRegion, Telephone, Fax)
VALUES 
(NEWID(), 'Ernst Handel', 'Roland Mendel', 'Kirchgasse 6', 'Graz', NULL,
	 '8010', 'Austria', '7675-3425', '7675-3426')
INSERT cust
(CustomerID, Company, ContactName, Address, City, StateProvince,
	 PostalCode, CountryRegion, Telephone, Fax)
VALUES 
(NEWID(), 'Maison Dewey', 'Catherine Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', NULL,
	 'B-1180', 'Belgium', '(02) 201 24 67', '(02) 201 24 68')
GO

