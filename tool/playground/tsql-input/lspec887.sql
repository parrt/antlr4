DECLARE @cookie varbinary(100);
EXECUTE AS USER = 'user1' WITH COOKIE INTO @cookie;
-- Store the cookie somewhere safe in your application.
-- Verify the context switch.
SELECT SUSER_NAME(), USER_NAME();
--Display the cookie value.
SELECT @cookie;
GO
-- Use the cookie in the REVERT statement.
DECLARE @cookie varbinary(100);
-- Set the cookie value to the one from the SELECT @cookie statement.
SET @cookie = 'jim'; --<value from the SELECT @cookie statement>;
REVERT WITH COOKIE = @cookie;
-- Verify the context switch reverted.
SELECT SUSER_NAME(), USER_NAME();
GO
