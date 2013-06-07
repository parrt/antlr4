CREATE TABLE TertColTable
(Col1 char(15) COLLATE SQL_Latin1_General_Pref_CP437_CI_AS,
	Col2 AS TERTIARY_WEIGHTS(Col1));
GO 

