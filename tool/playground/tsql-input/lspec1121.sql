USE tempdb;
GO
CREATE TABLE dbo.GroupingNULLS (
Store nvarchar(19)
,SaleYear nvarchar(4)
,SaleMonth nvarchar (7))
INSERT INTO dbo.GroupingNULLS VALUES
(NULL,NULL,'January')
,(NULL,'2002',NULL)
,(NULL,NULL,NULL)
,('Active Cycling',NULL ,'January')
,('Active Cycling','2002',NULL)
,('Active Cycling',NULL ,NULL)
,('Active Cycling',NULL,'January')
,('Active Cycling','2003','Febuary')
,('Active Cycling','2003',NULL)
,('Mountain Bike Store','2002','January')
,('Mountain Bike Store','2002',NULL)
,('Mountain Bike Store',NULL,NULL)
,('Mountain Bike Store','2003','January')
,('Mountain Bike Store','2003','Febuary')
,('Mountain Bike Store','2003','March');

SELECT ISNULL(Store,
CASE WHEN GROUPING(Store) = 0 THEN 'UNKNOWN' ELSE 'ALL' END)
AS Store
,ISNULL(CAST(SaleYear AS nvarchar(7)),
CASE WHEN GROUPING(SaleYear)= 0 THEN 'UNKNOWN' ELSE 'ALL' END)
AS SalesYear
,ISNULL(SaleMonth,
CASE WHEN GROUPING(SaleMonth) = 0 THEN 'UNKNOWN' ELSE 'ALL'END)
AS SalesMonth
,COUNT(*) AS Count
FROM dbo.GroupingNULLS 
GROUP BY ROLLUP(Store, SaleYear, SaleMonth);

GO
SELECT D.Name
    ,CASE
    WHEN GROUPING_ID(D.Name, E.JobTitle) = 0 THEN E.JobTitle
    WHEN GROUPING_ID(D.Name, E.JobTitle) = 1 THEN N'Total: ' + D.Name
    WHEN GROUPING_ID(D.Name, E.JobTitle) = 3 THEN N'Company Total:'
        ELSE N'Unknown'
    END AS N'Job Title'
    ,COUNT(E.BusinessEntityID) AS N'Employee Count'
FROM HumanResources.Employee E
    INNER JOIN HumanResources.EmployeeDepartmentHistory DH
        ON E.BusinessEntityID = DH.BusinessEntityID
    INNER JOIN HumanResources.Department D
        ON D.DepartmentID = DH.DepartmentID
WHERE DH.EndDate IS NULL
    AND D.DepartmentID IN (12,14)
GROUP BY ROLLUP(D.Name, E.JobTitle);

GO
SELECT D.Name
    ,E.JobTitle
    ,GROUPING_ID(D.Name, E.JobTitle) AS 'Grouping Level'
    ,COUNT(E.BusinessEntityID) AS N'Employee Count'
FROM HumanResources.Employee AS E
    INNER JOIN HumanResources.EmployeeDepartmentHistory AS DH
        ON E.BusinessEntityID = DH.BusinessEntityID
    INNER JOIN HumanResources.Department AS D
        ON D.DepartmentID = DH.DepartmentID
WHERE DH.EndDate IS NULL
    AND D.DepartmentID IN (12,14)
GROUP BY ROLLUP(D.Name, E.JobTitle)
--HAVING GROUPING_ID(D.Name, E.JobTitle) = 0; --All titles
--HAVING GROUPING_ID(D.Name, E.JobTitle) = 1; --Group by Name;
