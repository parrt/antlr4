--Partitioned view as defined on Server1
CREATE VIEW Customers
AS
--Select from local member table.
SELECT *
FROM CompanyData.dbo.Customers_33
UNION ALL
--Select from member table on Server2.
SELECT *
FROM Server2.CompanyData.dbo.Customers_66
UNION ALL
--Select from mmeber table on Server3.
SELECT *
FROM Server3.CompanyData.dbo.Customers_99
