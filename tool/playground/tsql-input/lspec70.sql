USE tempdb;
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
      WHERE TABLE_NAME = 'bitwise')
   DROP TABLE bitwise;
GO
CREATE TABLE bitwise
( 
a_int_value int NOT NULL,
b_int_value int NOT NULL
);
GO
INSERT bitwise VALUES (170, 75);
GO
