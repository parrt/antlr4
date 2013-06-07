USE AdventureWorks
GO
SELECT EmployeeID, RateChangeDate
FROM HumanResources.EmployeePayHistory
WHERE RateChangeDate BETWEEN '19971212' AND '19980105'
