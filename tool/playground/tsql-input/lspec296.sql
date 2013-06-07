USE AdventureWorks;
GO
CREATE TABLE myTable (column1 int, column2 varchar(256));
GO
INSERT INTO myTable VALUES (1, 'test');
GO
SELECT BINARY_CHECKSUM(*) from myTable;
GO
UPDATE myTable set column2 = 'TEST';
GO
SELECT BINARY_CHECKSUM(*) from myTable;
GO
