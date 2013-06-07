USE master;
GO
EXEC sp_databases;


USE AdventureWorks;
GO
EXEC sp_fkeys @pktable_name = N'Department',
   @pktable_owner = N'HumanResources'
USE AdventureWorks;
GO
EXEC sp_pkeys @table_name = N'Department',
   @table_owner = N'HumanResources'
USE AdventureWorks;
GO
EXEC sp_special_columns @table_name = 'Department', 
   @table_owner = 'HumanResources'
USE AdventureWorks;
GO
sp_stored_procedures;

USE AdventureWorks;
GO
sp_stored_procedures N'uspLogError', N'dbo', N'AdventureWorks', 1;

USE AdventureWorks;
GO
EXEC sp_table_privileges 
   @table_name = 'Contact%';
EXEC sp_tables ;
USE AdventureWorks;
GO
EXEC sp_tables 
   @table_name = '%',
   @table_owner = 'Person',
   @table_qualifier = 'AdventureWorks';

