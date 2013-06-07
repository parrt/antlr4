CREATE TABLE TestTab
   (PrimaryKey int PRIMARY KEY,
	    CharCol char(10) COLLATE French_CI_AS
	   )

	SELECT *
	FROM TestTab
	WHERE CharCol LIKE N'abc'

