SET DATEFIRST 5
SELECT @@DATEFIRST AS '1st Day', DATEPART(dw, GETDATE()) AS 'Today'
