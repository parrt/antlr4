USE Northwind;
GO
SELECT FT_TBL.Description, FT_TBL.CategoryName, KEY_TBL.RANK
FROM Categories AS FT_TBL 
    INNER JOIN CONTAINSTABLE (Categories, Description, 
        '("sweet and savory" NEAR sauces) OR
        ("sweet and savory" NEAR candies)'
        ) AS KEY_TBL
        ON FT_TBL.CategoryID = KEY_TBL.[KEY]
WHERE KEY_TBL.RANK > 2
    AND FT_TBL.CategoryName <> 'Seafood'
ORDER BY KEY_TBL.RANK DESC;
GO
