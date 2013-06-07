DECLARE @HashThis nvarchar(max);
SELECT @HashThis = CONVERT(nvarchar,'dslfdkjLK85kldhnv$n000#knf');
SELECT HashBytes('SHA1', @HashThis);
GO

