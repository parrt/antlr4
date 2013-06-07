-- Set date format to month, day, year.
SET DATEFORMAT mdy;
GO
DECLARE @datevar DATETIME;
SET @datevar = '12/31/1998';
SELECT @datevar AS DateVar;
GO
-- Result: 1998-12-31 00:00:00.000

-- Set date format to year, day, month.
SET DATEFORMAT ydm;
GO
DECLARE @datevar DATETIME;
SET @datevar = '1998/31/12';
SELECT @datevar AS DateVar;
GO
-- Result: 1998-12-31 00:00:00.000

-- Set date format to year, month, day.
SET DATEFORMAT ymd;
GO
DECLARE @datevar DATETIME;
SET @datevar = '1998/12/31';
SELECT @datevar AS DateVar;
GO
-- Result: 1998-12-31 00:00:00.000

