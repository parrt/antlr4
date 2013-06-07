USE AdventureWorks;
GO
SELECT 
    INDEXPROPERTY(OBJECT_ID('HumanResources.Employee'),
	        'PK_Employee_EmployeeID','IsClustered')AS [Is Clustered],
	    INDEXPROPERTY(OBJECT_ID('HumanResources.Employee'),
		        'PK_Employee_EmployeeID','IndexDepth') AS [Index Depth],
		    INDEXPROPERTY(OBJECT_ID('HumanResources.Employee'),
			        'PK_Employee_EmployeeID','IndexFillFactor') AS [Fill Factor];
			GO


