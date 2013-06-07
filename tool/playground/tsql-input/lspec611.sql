USE AdventureWorks;
GO
--Create a clustered index on the PRIMARY filegroup if it does not exist.
IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = 
	            N'AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate')
		    CREATE UNIQUE CLUSTERED INDEX
		        AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate 
			    ON Production.BillOfMaterials (ProductAssemblyID, ComponentID, 
				        StartDate)
				    ON 'PRIMARY';
				GO
				-- Verify filegroup location of the clustered index.
SELECT t.name AS [Table Name], i.name AS [Index Name], i.type_desc,
    i.data_space_id, f.name AS [Filegroup Name]
FROM sys.indexes AS i
    JOIN sys.filegroups AS f ON i.data_space_id = f.data_space_id
    JOIN sys.tables as t ON i.object_id = t.object_id
        AND i.object_id = OBJECT_ID(N'Production.BillOfMaterials','U')
	GO
	--Create filegroup NewGroup if it does not exist.
-- Get the SQL Server data path
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
	                  FROM master.sys.master_files
			                  WHERE database_id = 1 AND file_id = 1);

				-- execute the ALTER DATABASE statement 
IF NOT EXISTS (SELECT name FROM sys.filegroups
	                WHERE name = N'NewGroup')
			    BEGIN
				    ALTER DATABASE AdventureWorks
				        ADD FILEGROUP NewGroup;
					    EXECUTE ('ALTER DATABASE AdventureWorks
						        ADD FILE (NAME = File1,
								            FILENAME = '''+ @data_path + 'File1.ndf'')
								        TO FILEGROUP NewGroup');
								    END
								GO
								--Verify new filegroup
SELECT * from sys.filegroups;
GO
-- Drop the clustered index and move the BillOfMaterials table to
-- the Newgroup filegroup.
-- Set ONLINE = OFF to execute this example on editions other than Enterprise Edition.
DROP INDEX AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate 
    ON Production.BillOfMaterials 
    WITH (ONLINE = ON, MOVE TO NewGroup);
GO
-- Verify filegroup location of the moved table.
SELECT t.name AS [Table Name], i.name AS [Index Name], i.type_desc,
    i.data_space_id, f.name AS [Filegroup Name]
FROM sys.indexes AS i
    JOIN sys.filegroups AS f ON i.data_space_id = f.data_space_id
    JOIN sys.tables as t ON i.object_id = t.object_id
        AND i.object_id = OBJECT_ID(N'Production.BillOfMaterials','U');
	GO


