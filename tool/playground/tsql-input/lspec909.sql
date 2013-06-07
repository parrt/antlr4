USE AdventureWorks ;
GO
SELECT AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode  
FROM Person.Address AS a
JOIN Person.StateProvince AS s ON a.StateProvinceID = s.StateProvinceID
WHERE CountryRegionCode NOT IN ('US')
AND City LIKE N'Mn%' ;

