USE AdventureWorks
GO
EXEC sp_columns @table_name = N'Department',
   @table_owner = N'HumanResources';

