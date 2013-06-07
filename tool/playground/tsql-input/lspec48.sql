USE AdventureWorks ;
GO
SELECT *
FROM HumanResources.Employee e1
UNION
SELECT *
FROM HumanResources.Employee e2
OPTION (MERGE UNION) ;
GO

