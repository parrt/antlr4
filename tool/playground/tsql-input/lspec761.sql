USE tempdb
CREATE TABLE test_dates (Col_1 varchar(15), Col_2 datetime)
GO
INSERT INTO test_dates VALUES ('abc', 'July 13, 1998')
GO
SELECT ISDATE(Col_1) AS Col_1, ISDATE(Col_2) AS Col_2 
   FROM test_dates

