USE Northwind;
GO
SELECT FT_TBL.CategoryName, FT_TBL.Description, KEY_TBL.RANK
    FROM Categories AS FT_TBL 
        INNER JOIN CONTAINSTABLE(Categories, Description, 
        'ISABOUT (breads weight (.8), 
        fish weight (.4), beers weight (.2) )' ) AS KEY_TBL
            ON FT_TBL.CategoryID = KEY_TBL.[KEY]
ORDER BY KEY_TBL.RANK DESC;
GO
