SELECT * 
FROM TestTab 
WHERE GreekCol = LatinCol;
SELECT * 
FROM TestTab 
WHERE GreekCol = LatinCol COLLATE greek_ci_as;
SELECT (CASE WHEN id > 10 THEN GreekCol ELSE LatinCol END) 
FROM TestTab;
SELECT PATINDEX((CASE WHEN id > 10 THEN GreekCol ELSE LatinCol END), 'a')
FROM TestTab
SELECT (CASE WHEN id > 10 THEN GreekCol ELSE LatinCol END) COLLATE Latin1_General_CI_AS 
FROM TestTab
CREATE TABLE ExampleTable (PriKey int PRIMARY KEY, VarCharCol national character varying(10))

