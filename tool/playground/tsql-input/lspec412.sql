USE AdventureWorks;
GO
CREATE TABLE #Test (C1 nvarchar(10), C2 nvarchar(50), C3 datetime);
GO
CREATE UNIQUE INDEX AK_Index ON #Test (C2)
    WITH (IGNORE_DUP_KEY = ON);
GO
INSERT INTO #Test VALUES (N'OC', N'Ounces', GETDATE());
INSERT INTO #Test SELECT * FROM Production.UnitMeasure;
GO
SELECT COUNT(*)AS [Number of rows] FROM #Test;
GO
DROP TABLE #Test;
GO
