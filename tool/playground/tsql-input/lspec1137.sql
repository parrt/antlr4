USE AdventureWorks2008R2;
GO

/* Create a user-defined table type */
CREATE TYPE LocationTableType AS TABLE 
( LocationName VARCHAR(50)
	, CostRate INT );
GO

