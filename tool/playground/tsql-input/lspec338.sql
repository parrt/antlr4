USE AdventureWorks;
GO
CREATE TABLE t1
   (c1 varchar(40),
    c2 nvarchar(40)
   );
GO
SELECT COL_LENGTH('t1','c1')AS 'VarChar',
      COL_LENGTH('t1','c2')AS 'NVarChar';
GO
DROP TABLE t1;
