DROP TABLE ProductVendor1 ;
DROP TABLE AdventureWorks.dbo.SalesPerson2 ;
USE AdventureWorks;
GO
CREATE TABLE #temptable (col1 int);
GO
INSERT INTO #temptable
VALUES (10);
GO
SELECT * FROM #temptable;
GO
IF OBJECT_ID(N'tempdb..#temptable', N'U') IS NOT NULL 
	DROP TABLE #temptable;
	GO
	--Test the drop.
SELECT * FROM #temptable;


