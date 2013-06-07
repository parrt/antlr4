DECLARE @PathName nvarchar(max)
SET @PathName = (
SELECT TOP 1 photo.PathName()
FROM dbo.Customer
WHERE LastName = 'CustomerName'
);

