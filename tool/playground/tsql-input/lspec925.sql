USE AdventureWorks;
GO

-- Set the 'ANSI null default' database option to true by executing 
-- ALTER DATABASE.
GO
ALTER DATABASE AdventureWorks SET ANSI_NULL_DEFAULT ON;
GO
-- Create table t1.
CREATE TABLE t1 (a TINYINT);
GO
-- NULL INSERT should succeed.
INSERT INTO t1 (a) VALUES (NULL);
GO

-- SET ANSI_NULL_DFLT_OFF to ON and create table t2.
SET ANSI_NULL_DFLT_OFF ON;
GO
CREATE TABLE t2 (a TINYINT);
GO 
-- NULL INSERT should fail.
INSERT INTO t2 (a) VALUES (NULL);
GO

-- SET ANSI_NULL_DFLT_OFF to OFF and create table t3.
SET ANSI_NULL_DFLT_OFF OFF;
GO
CREATE TABLE t3 (a TINYINT) ;
GO 
-- NULL INSERT should succeed.
INSERT INTO t3 (a) VALUES (NULL);
GO

-- This illustrates the effect of having both the database
-- option and SET option disabled.
-- Set the 'ANSI null default' database option to false.
ALTER DATABASE AdventureWorks SET ANSI_NULL_DEFAULT OFF;
GO
-- Create table t4.
CREATE TABLE t4 (a tinyint) ;
GO 
-- NULL INSERT should fail.
INSERT INTO t4 (a) VALUES (null);
GO

-- SET ANSI_NULL_DFLT_OFF to ON and create table t5.
SET ANSI_NULL_DFLT_OFF ON;
GO
CREATE TABLE t5 (a tinyint);
GO 
-- NULL insert should fail.
INSERT INTO t5 (a) VALUES (null);
GO

-- SET ANSI_NULL_DFLT_OFF to OFF and create table t6.
SET ANSI_NULL_DFLT_OFF OFF;
GO
CREATE TABLE t6 (a tinyint); 
GO 
-- NULL insert should fail.
INSERT INTO t6 (a) VALUES (null);
GO

-- Drop tables t1 through t6.
DROP TABLE t1
DROP TABLE t2
DROP TABLE t3
DROP TABLE t4
DROP TABLE t5
DROP TABLE t6

