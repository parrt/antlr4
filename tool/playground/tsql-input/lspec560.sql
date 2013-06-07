USE AdventureWorks;
GO
CREATE TABLE Table1 (Col1 int, Col2 char (30));
GO
INSERT INTO Table1 VALUES (100, 'Hello');
GO
ALTER TABLE Table1 WITH NOCHECK ADD CONSTRAINT chkTab1 CHECK (Col1 > 100);
GO
DBCC CHECKCONSTRAINTS('Table1');
GO

USE AdventureWorks;
GO
DBCC CHECKCONSTRAINTS ('Production.CK_ProductCostHistory_EndDate');
GO

USE AdventureWorks;
GO
DBCC CHECKCONSTRAINTS ('Production.CK_ProductCostHistory_EndDate');
GO


