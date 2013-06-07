USE AdventureWorks;
GO
WITH DirReps(ManagerID, DirectReports) AS 
(
	    SELECT ManagerID, COUNT(*) 
	    FROM HumanResources.Employee AS e
	    WHERE ManagerID IS NOT NULL
	    GROUP BY ManagerID
)
SELECT ManagerID, DirectReports 
FROM DirReps 
ORDER BY ManagerID;
GO
