USE AdventureWorks;
GO
EXEC sp_column_privileges @table_name = 'Employee', 
   @table_owner = 'HumanResources', 
   @table_qualifier = 'AdventureWorks',
   @column_name = 'SalariedFlag'

