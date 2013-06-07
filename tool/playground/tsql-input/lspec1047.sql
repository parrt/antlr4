WITH DirReps (Manager, DirectReports) AS 
(
	    SELECT ManagerID, COUNT(*) AS DirectReports
	    FROM HumanResources.Employee
	    GROUP BY ManagerID
) 
SELECT AVG(DirectReports) AS [Average Number of Direct Reports]
FROM DirReps 
WHERE DirectReports>= 2 ;
GO
