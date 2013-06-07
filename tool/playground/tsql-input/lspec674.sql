USE Northwind;
SELECT FT_TBL.CategoryName 
    ,FT_TBL.Description
    ,KEY_TBL.RANK
FROM dbo.Categories AS FT_TBL 
    INNER JOIN FREETEXTTABLE(dbo.Categories, Description, 
	  'sweetest candy bread and dry meat') AS KEY_TBL
	  ON FT_TBL.CategoryID = KEY_TBL.[KEY];
	  GO

USE Northwind;
SELECT FT_TBL.CategoryName 
    ,FT_TBL.Description
    ,KEY_TBL.RANK
FROM dbo.Categories AS FT_TBL 
    INNER JOIN FREETEXTTABLE(dbo.Categories, Description, 
		'sweetest candy bread and dry meat',LANGUAGE 'English',2) 
		AS KEY_TBL
			ON FT_TBL.CategoryID = KEY_TBL.[KEY];
			GO

