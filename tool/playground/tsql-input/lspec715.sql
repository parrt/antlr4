USE AdventureWorks ;
GO
SELECT DATEPART(yyyy,OrderDate) AS Year,
SUM(TotalDue) AS AverageOrderAmt
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(yyyy,OrderDate)
ORDER BY DATEPART(yyyy,OrderDate) ;


