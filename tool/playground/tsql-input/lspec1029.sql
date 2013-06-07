DECLARE @usr char(30)
SET @usr = user
SELECT 'The current user''s database username is: '+ @usr
GO
