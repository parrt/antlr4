USE AdventureWorks;
GO
SELECT Color, SUM(ListPrice), SUM(StandardCost)
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice != 0.00 AND Name LIKE 'Mountain%'
GROUP BY Color
ORDER BY Color;
GO
USE AdventureWorks;
GO
SELECT Color, ListPrice, StandardCost
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice != 0.00 AND Name LIKE 'Mountain%'
ORDER BY Color
COMPUTE SUM(ListPrice), SUM(StandardCost) BY Color;
GO
USE AdventureWorks;
GO
SELECT Color, SUM(ListPrice), SUM(StandardCost)
FROM Production.Product
GROUP BY Color
ORDER BY Color
GO


