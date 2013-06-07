CREATE PARTITION FUNCTION myRangePF1 (int)
AS RANGE LEFT FOR VALUES (1, 100, 1000) ;
GO
CREATE PARTITION SCHEME myRangePS1
AS PARTITION myRangePF1
TO (test1fg, test2fg, test3fg, test4fg) ;
GO
CREATE TABLE PartitionTable1 
(col1 int, col2 varchar(max))
ON myRangePS1 (col1) 
WITH 
(
	  DATA_COMPRESSION = ROW ON PARTITIONS (1),
	  DATA_COMPRESSION = PAGE ON PARTITIONS (2 TO 4)
);
GO

