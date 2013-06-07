USE Northwind;
SELECT FT_TBL.Description, FT_TBL.CategoryName , KEY_TBL.RANK
FROM Categories AS FT_TBL 
    INNER JOIN CONTAINSTABLE (Categories, Description, 
        '("sweet and savory" NEAR sauces) OR
        ("sweet and savory" NEAR candies)', 10)
        AS KEY_TBL
        ON FT_TBL.CategoryID = KEY_TBL.[KEY]
