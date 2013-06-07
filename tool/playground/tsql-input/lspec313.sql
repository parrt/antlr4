SELECT 
   '2006-04-04T15:50:59.997' AS UnconvertedText,
   CAST('2006-04-04T15:50:59.997' AS datetime) AS UsingCast,
   CONVERT(datetime, '2006-04-04T15:50:59.997', 126) AS UsingConvertFrom_ISO8601 ;
GO
