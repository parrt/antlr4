DECLARE @nstring nchar(8)
SET @nstring = N'København'
SELECT UNICODE(SUBSTRING(@nstring, 2, 1)), 
   NCHAR(UNICODE(SUBSTRING(@nstring, 2, 1)))
GO

