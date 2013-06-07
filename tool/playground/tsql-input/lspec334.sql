CREATE TABLE #CheckSumTest 
(
        ID int identity ,
        Num int DEFAULT ( RAND() * 100 ) ,
        RowCheckSum AS COALESCE( CHECKSUM( id , num ) , 0 ) PERSISTED PRIMARY KEY
)
