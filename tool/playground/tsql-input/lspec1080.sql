CREATE TABLE PartitionTable2 
(col1 int, col2 varchar(max))
ON myRangePS1 (col1) 
WITH 
(
	  DATA_COMPRESSION = ROW ON PARTITIONS (1,3),
	  DATA_COMPRESSION = NONE ON PARTITIONS (2,4)
);
GO

