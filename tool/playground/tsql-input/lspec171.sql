ALTER ENDPOINT sql_endpoint
FOR SOAP
(
  ADD WEBMETHOD 'ReportUsageStats' (name='myDatabase.dbo.sp_reportserverstats', FORMAT=NONE)
);
