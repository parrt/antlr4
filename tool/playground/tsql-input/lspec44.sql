USE AdventureWorks ;
GO
-- Add first row with a NULL customer name and 0 orders.
-- INSERT dbo.CubeExample (ProductName, CustomerName, Orders)
-- VALUES ('Ikura', NULL, 0)

-- Add second row with a NULL product and NULL customer with real value 
-- for orders.
-- INSERT dbo.CubeExample (ProductName, CustomerName, Orders)
-- VALUES (NULL, NULL, 50)

-- Add third row with a NULL product, NULL order amount, but a real 
-- customer name.
-- INSERT dbo.CubeExample (ProductName, CustomerName, Orders)
-- VALUES (NULL, 'Wilman Kala', NULL)

SELECT ProductName AS Prod, CustomerName AS Cust, 
SUM(Orders) AS 'Sum Orders',
GROUPING(ProductName) AS 'Group ProductName',
GROUPING(CustomerName) AS 'Group CustomerName'
FROM CubeExample
GROUP BY ProductName, CustomerName
WITH ROLLUP ;
GO

