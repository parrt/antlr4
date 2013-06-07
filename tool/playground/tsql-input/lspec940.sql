USE AdventureWorks;
GO
-- Create tool table.
CREATE TABLE dbo.Tool(
	   ID INT IDENTITY NOT NULL PRIMARY KEY, 
	   Name VARCHAR(40) NOT NULL
)
GO
-- Inserting values into products table.
INSERT INTO dbo.Tool(Name) VALUES ('Screwdriver')
INSERT INTO dbo.Tool(Name) VALUES ('Hammer')
INSERT INTO dbo.Tool(Name) VALUES ('Saw')
INSERT INTO dbo.Tool(Name) VALUES ('Shovel')
GO

-- Create a gap in the identity values.
DELETE dbo.Tool 
WHERE Name = 'Saw'
GO

SELECT * 
FROM dbo.Tool
GO

-- Try to insert an explicit ID value of 3;
-- should return a warning.
INSERT INTO dbo.Tool (ID, Name) VALUES (3, 'Garden shovel')
GO
-- SET IDENTITY_INSERT to ON.
SET IDENTITY_INSERT dbo.Tool ON
GO

-- Try to insert an explicit ID value of 3.
INSERT INTO dbo.Tool (ID, Name) VALUES (3, 'Garden shovel')
GO

SELECT * 
FROM dbo.Tool
GO
-- Drop products table.
DROP TABLE dbo.Tool
GO

