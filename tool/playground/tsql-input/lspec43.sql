USE AdventureWorks ;
GO
SELECT CompanyName, Department, SUM(NumEmployees)
FROM dbo.Personnel
GROUP BY CompanyName, Department WITH ROLLUP ;
GO

