USE AdventureWorks;
GO

SELECT e.FirstName, e.LastName, ep.Rate
FROM HumanResources.vEmployee e 
JOIN HumanResources.EmployeePayHistory ep 
    ON e.EmployeeID = ep.EmployeeID
WHERE ep.Rate > 27 AND ep.Rate < 30
ORDER BY ep.Rate;
GO
