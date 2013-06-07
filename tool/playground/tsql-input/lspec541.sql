USE tempdb;
GO

CREATE TABLE TestTab (
	   id int, 
	   GreekCol nvarchar(10) collate greek_ci_as, 
	   LatinCol nvarchar(10) collate latin1_general_cs_as
	   )
	INSERT TestTab VALUES (1, N'A', N'a');
	GO

