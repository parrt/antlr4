USE AdventureWorks;
GO
IF OBJECT_ID (N'dbo.ufn_FindReports', N'TF') IS NOT NULL
    DROP FUNCTION dbo.ufn_FindReports;
GO
CREATE FUNCTION dbo.ufn_FindReports (@InEmpID INTEGER)
RETURNS @retFindReports TABLE 
(
    EmployeeID int primary key NOT NULL,
    Name nvarchar(255) NOT NULL,
    Title nvarchar(50) NOT NULL,
    EmployeeLevel int NOT NULL,
    Sort nvarchar (255) NOT NULL
)
--Returns a result set that lists all the employees who report to the 
--specific employee directly or indirectly.*/
AS
BEGIN
   WITH DirectReports(Name, Title, EmployeeID, EmployeeLevel, Sort) AS
    (SELECT CONVERT(Varchar(255), c.FirstName + ' ' + c.LastName),
        e.Title,
        e.EmployeeID,
        1,
        CONVERT(Varchar(255), c.FirstName + ' ' + c.LastName)
     FROM HumanResources.Employee AS e
          JOIN Person.Contact AS c ON e.ContactID = c.ContactID 
     WHERE e.EmployeeID = @InEmpID
   UNION ALL
     SELECT CONVERT(Varchar(255), REPLICATE ('| ' , EmployeeLevel) +
        c.FirstName + ' ' + c.LastName),
        e.Title,
        e.EmployeeID,
        EmployeeLevel + 1,
        CONVERT (Varchar(255), RTRIM(Sort) + '| ' + FirstName + ' ' + 
                 LastName)
     FROM HumanResources.Employee as e
          JOIN Person.Contact AS c ON e.ContactID = c.ContactID
          JOIN DirectReports AS d ON e.ManagerID = d.EmployeeID
    )
-- copy the required columns to the result of the function 
   INSERT @retFindReports
   SELECT EmployeeID, Name, Title, EmployeeLevel, Sort
   FROM DirectReports 
   RETURN
END;
GO
-- Example invocation
SELECT EmployeeID, Name, Title, EmployeeLevel
FROM dbo.ufn_FindReports(109)
ORDER BY Sort;
GO

