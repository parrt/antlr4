DECLARE @city_name nvarchar(30)
SET @city_name = 'Ascheim'
SELECT * FROM Person.Address
WHERE City = @city_name
OPTION ( OPTIMIZE FOR (@city_name = 'Seattle') );
GO

