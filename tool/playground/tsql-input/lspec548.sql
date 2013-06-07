USE AdventureWorks;
GO
SELECT StartDate, DATENAME(month,StartDate) AS StartMonth
FROM Production.WorkOrder
WHERE WorkOrderID = 1;
GO

