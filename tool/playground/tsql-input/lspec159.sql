USE master;
GO
ALTER DATABASE AdventureWorks
MODIFY FILE
(
    NAME = Test1dat2,
    FILENAME = N'c:\t1dat2.ndf'
);
GO
