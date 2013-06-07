CREATE DATABASE TestDatabase
ON  PRIMARY
( NAME = TestDatabase,
	    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\TestDB.mdf'),
	FILEGROUP test1fg
( NAME = TestDBFile1,
		FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\TestDBFile1.mdf'),
	FILEGROUP test2fg
( NAME = TestDBFile2,
		FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\TestDBFile2.ndf'),
	FILEGROUP test3fg
( NAME = TestDBFile3,
		FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\TestDBFile3.ndf'),
	FILEGROUP test4fg
( NAME = TestDBFile4,
		FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\TestDBFile4.ndf') ;
GO

