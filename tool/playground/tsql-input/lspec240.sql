DECLARE @MySchemaCollection nvarchar(max)
Set @MySchemaCollection  = N' copy the schema collection here'
CREATE XML SCHEMA COLLECTION AS @MySchemaCollection 
